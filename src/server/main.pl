:- use_module(library(http/http_server)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).
:- use_module(library(filesex)).
:- use_module(library(http/json_convert)).

:- consult('../rules/recommendation_rules.pl').  % Import soil facts for tubers (replace with your actual files)


% Starting the server
:- dynamic server_running/0.

start :-
    server_running,
    write('Server is already running.'), nl.
start :-
    \+ server_running,
    http_server(http_dispatch, [port(8080)]),
    asserta(server_running).

stop :-
    server_running,
    http_stop_server(8080, []),
    retract(server_running),
    write('Server stopped.'), nl.
stop :-
    \+ server_running,
    write('No server is running.'), nl.




% HTTP request handler for recommendation (only GET)
:- http_handler(root(recommendation), recommend_fertilizer_request, []).

% HTTP request handler for home (render HTML file from server)
:- http_handler('/', serve_html_file, []).


% HTTP handler to process fertilizer recommendation (GET request)
% HTTP handler to process fertilizer recommendation (GET or POST request)
recommend_fertilizer_request(Request) :-
    (   member(method(post), Request)
    ->  process_json_request(Request)
    ;   member(method(get), Request)
    ->  process_query_params(Request)
    ;   reply_json(json{error: "Unsupported HTTP method"}, [status(405)])
    ),
    !.



% Process GET requests with query parameters
process_query_params(Request) :-
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

% Process POST requests with JSON data
process_json_request(Request) :-
    http_read_json_dict(Request, Data),
    % Log incoming data
    write('Received data: '), write(Data), nl,
    
    % Extract data from JSON dictionary
    CropType = Data.get(cropType),
    GrowthStage = Data.get(growthStage),
    YieldTarget = Data.get(yieldTarget),
    FertilizerHistory = Data.get(fertilizerHistory),
    WaterRequirements = Data.get(waterRequirements),
    Temperature = Data.get(temperature),
    Humidity = Data.get(humidity),
    Rainfall = Data.get(rainfall),
    Season = Data.get(season),
    Location = Data.get(location),
    PhLevel = Data.get(pHLevel),
    Nitrogen = Data.get(nitrogen),
    Phosphorous = Data.get(phosphorous),
    Potassium = Data.get(potassium),
    SoilType = Data.get(soilType),
    OrganicMatter = Data.get(organicMatter),
    SoilMoisture = Data.get(soilMoisture),
    ElectricalConductivity = Data.get(electricalConductivity),

    % Log parsed parameters
    write('Parsed parameters: '), nl,
    write('CropType: '), write(CropType), nl,
    write('GrowthStage: '), write(GrowthStage), nl,
    write('YieldTarget: '), write(YieldTarget), nl,
    % Continue logging other fields as needed...

    % Call recommendation logic
    recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, Recommendation),

    % Log the recommendation
    write('Recommendation: '), write(Recommendation), nl,

    % Respond with JSON
    format('Content-type: application/json~n~n'),  % Set Content-Type header to application/json
    reply_json_dict(Recommendation).





% recommendation_to_json(Recommendation, JsonResponse) :-
%     Recommendation = json{
%         fertilizerType := Type,
%         NPK := NPK,
%         applicationMode := Mode,
%         frequency := Frequency,
%         reasoning := Reasoning
%     },
%     NPK = json{
%         ratio := Ratio,
%         values := json{N := N, P := P, K := K},
%         units := Units
%     },
%     JsonResponse = json{
%         fertilizerType := Type,
%         NPK := json{
%             ratio := Ratio,
%             values := json{N := N, P := P, K := K},
%             units := Units
%         },
%         applicationMode := Mode,
%         frequency := Frequency,
%         reasoning := Reasoning
%     }.




% Handle request parameters and send JSON response
handle_request_params(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity) :-
    % Call recommendation logic
    recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, Recommendation),
    % Set the Content-Type header
    format('Content-type: application/json~n~n'),
    % Return the result as JSON
    reply_json(Recommendation).





% HTTP handler for serving HTML file (Hello World or Custom HTML)
serve_html_file(_Request) :-
    HtmlFilePath = '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/index.html', % Correct the file path
    (   exists_file(HtmlFilePath)
    ->  read_file_to_string(HtmlFilePath, FileContent, []),
        format('Content-type: text/html~n~n'),
        write(FileContent)
    ;   
        format('Content-type: text/html~n~n'),
        write('<h1 style="color: red;">Error: File not found</h1>')
    ).


% Main entry point for starting the server
:- initialization(start).


% Place this in the browser for the home
% http://localhost:8080/home


% Place this in the browser to get recommendations
% http://localhost:8080/recommendation?cropType=cereal&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=moderate&season=spring&location=temperate&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate


% Run this to start server
% ['/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/server/main.pl'].