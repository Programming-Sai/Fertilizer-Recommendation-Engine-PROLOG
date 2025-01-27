% Import the fact files (soil facts split by crop type, and other fact files)
:- consult('./src/facts/crop_facts.pl').         % Import crop facts
:- consult('./src/facts/environmental_facts.pl').  % Import environment facts
:- consult('./src/facts/soil_facts/cereal_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/vegetable_soil_facts.pl').  % Import soil facts for vegetables (replace with your actual files)
:- consult('./src/facts/soil_facts/fruit_soil_facts.pl').  % Import soil facts for fruits (replace with your actual files)
:- consult('./src/facts/soil_facts/legume_soil_facts.pl').  % Import soil facts for legumes (replace with your actual files)
:- consult('./src/facts/soil_facts/oilseed_soil_facts.pl').  % Import soil facts for oilseeds (replace with your actual files)
:- consult('./src/facts/soil_facts/tuber_soil_facts.pl').  % Import soil facts for tubers (replace with your actual files)

% Import the fact files
% :- consult('./src/facts/crop_facts.pl').         % Crop facts
% :- consult('./src/facts/environmental_facts.pl').  % Environmental facts
% :- consult('./src/facts/soil_facts/cereal_soil_facts.pl').  % Soil facts for cereal

% General soil checking predicate
check_soil_facts(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) :-
    % List of soil predicates based on crop types
    (   CropType == cereal -> soil_cereal(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ;   CropType == vegetable -> soil_vegetable(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ;   CropType == oilseed -> soil_oilseed(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ;   CropType == legume -> soil_legume(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ;   CropType == tuber -> soil_tuber(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ;   CropType == fruit -> soil_fruit(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)
    ).

% Recommendation Rule
recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, 
                     SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, 
                     Temperature, Humidity, Rainfall, Season, Location, Recommendation) :-
    % Check crop facts
    ( crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement) ->
        format("Crop fact found: ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement])
    ;
        format("Crop fact NOT found: ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement]),
        fail
    ),

    % Check environmental facts
    ( environment(CropType, Temperature, Humidity, Rainfall, Season, Location) ->
        format("Environment fact found: ~w, ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, Temperature, Humidity, Rainfall, Season, Location])
    ;
        format("Environment fact NOT found: ~w, ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, Temperature, Humidity, Rainfall, Season, Location]),
        fail
    ),

    % Check soil facts
    ( check_soil_facts(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) ->
        format("Soil fact found: ~w, ~w, ~w, ~w, ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity])
    ;
        format("Soil fact NOT found: ~w, ~w, ~w, ~w, ~w, ~w, ~w, ~w, ~w~n", 
               [CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity]),
        fail
    ),

    % If all facts match, provide a recommendation
    fertilizer_recommendation(CropType, Nitrogen, Phosphorous, Potassium, SoilType, ApplicationMode, Frequency, Recommendation).






% Define a separate predicate for fertilizer recommendations based on conditions
fertilizer_recommendation(CropType, Nitrogen, Phosphorous, Potassium, SoilType, ApplicationMode, Frequency, Recommendation) :-
    ( CropType == cereal ->
        ( Nitrogen == high, Phosphorous == high, Potassium == high ->
            Recommendation = "Use NPK 10:10:10 with broadcasting, apply every 30 days."
        ;
            Nitrogen == moderate, Phosphorous == moderate, Potassium == moderate ->
            Recommendation = "Use compost with side-dressing, apply every 60 days."
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high ->
            Recommendation = "Use NPK 20:10:10 with fertigation, apply every 30 days."
        ;
            Nitrogen == moderate, Phosphorous == low, Potassium == moderate ->
            Recommendation = "Use organic fertilizer with broadcasting, apply every 40 days."
        )
    ;
    Recommendation = "No suitable recommendation available."
    ).
