% Import the fact files (soil facts split by crop type, and other fact files)
:- consult('./src/facts/crop_facts.pl').         % Import crop facts
:- consult('./src/facts/environmental_facts.pl').  % Import environment facts
:- consult('./src/facts/soil_facts/cereal_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/vegetable_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/fruit_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/legume_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/oilseed_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('./src/facts/soil_facts/tuber_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)


% Dynamic declaration (if you're adding new facts during runtime)
:- dynamic crop/5.             % Crop facts are dynamic
:- dynamic soil/9.             % Soil facts are dynamic

% Recommendation Rule
recommend_fertilizer(CropType, GrowthStage, YieldTarget, Recommendation) :-
    % Fetch crop, soil, and environmental data from the facts
    crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement),
    soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity),
    environment(CropType, Temp, Humidity, Rainfall, Season, Location),
    
    % Fertilizer recommendation based on crop needs
    (YieldTarget == high_yield -> FertilizerType = npk; FertilizerType = organic),
    NPKRatio = "1:1:1",  % Default NPK ratio for simplicity (could be refined with more specific rules)
    N = 1, P = 1, K = 1,  % Default NPK values for simplicity

    % Application method based on soil moisture and growth stage
    (SoilMoisture == high -> ApplicationMode = 'drilling'; ApplicationMode = 'broadcasting'),
    
    % Frequency: Once per growth cycle (adjust as needed)
    Frequency = "Once per growth cycle",

    % Reasoning
    Reasoning = [
        "Soil type and moisture levels dictate application method.",
        "Crop requires moderate to high fertilization due to high yield target."
    ],

    % Construct the recommendation structure
    Recommendation = [
        fertilizerType(FertilizerType),
        npk(ratio(NPKRatio), values(nitrogen(N), phosphorous(P), potassium(K)), units('kg/ha')),
        applicationMode(ApplicationMode),
        frequency(Frequency),
        reasoning(Reasoning)
    ].

% Example of how to add a new crop fact dynamically (if needed)
add_crop_fact(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement) :-
    assert(crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement)).

% Example of how to add a new soil fact dynamically (if needed)
add_soil_fact(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) :-
    assert(soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity)).

% Example of how to add an environment fact dynamically (if needed)
add_environment_fact(CropType, Temp, Humidity, Rainfall, Season, Location) :-
    assert(environment(CropType, Temp, Humidity, Rainfall, Season, Location)).
