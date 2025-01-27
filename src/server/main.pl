:- use_module(library(http/http_server)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
:- use_module(library(filesex)).

% Starting the server
start_server :-
    http_server(http_dispatch, [port(8080)]).

% HTTP request handler for recommendation (only GET)
:- http_handler(root(recommendation), recommend_fertilizer_request, []).

% HTTP request handler for home (render HTML file from server)
:- http_handler(root(home), serve_html_file, []).

% HTTP handler to process fertilizer recommendation (GET request)
recommend_fertilizer_request(Request) :-
    http_parameters(Request, [
        cropType(CropType, []),
        growthStage(GrowthStage, []),
        yieldTarget(YieldTarget, []),
        fertilizerHistory(FertilizerHistory, []),
        waterRequirements(WaterRequirements, []),
        temperature(Temperature, []),
        humidity(Humidity, []),
        rainfall(Rainfall, []),
        season(Season, []),
        location(Location, []),
        pHLevel(PhLevel, []),
        nitrogen(Nitrogen, []),
        phosphorous(Phosphorous, []),
        potassium(Potassium, []),
        soilType(SoilType, []),
        organicMatter(OrganicMatter, []),
        soilMoisture(SoilMoisture, []),
        electricalConductivity(ElectricalConductivity, [])
    ]),
    handle_request_params(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity).

% Handle GET requests with query parameters
handle_request_params(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity) :-
    % Call recommendation logic
    recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, Recommendation),
    % Return the result as JSON
    reply_json(Recommendation).

% HTTP handler for serving HTML file (Hello World or Custom HTML)
serve_html_file(_Request) :-
    HtmlFilePath = '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/index.html', % Correct the file path
    (   exists_file(HtmlFilePath)
    ->  read_file_to_string(HtmlFilePath, FileContent, []),
        format('HTTP/1.1 200 OK~nContent-Type: text/html~n~n'),
        write(FileContent)
    ;   format('HTTP/1.1 404 Not Found~nContent-Type: text/html~n~n'),
        write('<h1>Error: File not found</h1>')
    ).

% Main entry point for starting the server
:- initialization(start_server).


% Place this in the browser for the home
% http://localhost:8080/home


% Place this in the browser to get recommendations
% http://localhost:8080/recommendation?cropType=cereal&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=moderate&season=spring&location=temperate&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate


% Run this to start server
% ['/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/server/main.pl'].