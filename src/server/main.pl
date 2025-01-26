:- consult('src/facts/recommendation_query.pl').
:- consult('src/facts/validation_rules.pl').

% Importing HTTP server library
:- use_module(library(http/http_server)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_json)).

% Starting the server
start_server :-
    http_server(http_dispatch, [port(8080)]).

% HTTP request handler for recommendation
:- http_handler(root(recommendation), recommend_fertilizer_request, []).

% HTTP handler to process fertilizer recommendation
recommend_fertilizer_request(Request) :-
    % Extract parameters from HTTP request
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
        electricalConductivity(ElectricalConductivity, []),
        preferredFertilizerType(PreferredFertilizerType, []),
        preferredApplicationMethod(PreferredApplicationMethod, [])
    ]),

    % Call recommendation logic
    recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation),
    
    % Return the result as JSON
    reply_json(Recommendation).

% Main entry point for starting the server
:- initialization(start_server).


% Run server
% swipl -s server/main.pl
% Example request
% curl -X GET "http://localhost:8080/recommendation?cropType=cereal&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=moderate&season=spring&location=temperate&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate&preferredFertilizerType=NPK&preferredApplicationMethod=broadcasting"
% 