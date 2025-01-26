:- consult('src/facts/recommendation_query.pl').
:- consult('src/facts/validation_rules.pl').

% Main entry point for fertilizer recommendation
main :-
    % Example input conditions (You can modify these inputs or get them dynamically)
    write('Enter crop type: '), read(CropType),
    write('Enter growth stage: '), read(GrowthStage),
    write('Enter yield target: '), read(YieldTarget),
    write('Enter fertilizer history: '), read(FertilizerHistory),
    write('Enter water requirements: '), read(WaterRequirements),
    write('Enter temperature: '), read(Temperature),
    write('Enter humidity: '), read(Humidity),
    write('Enter rainfall: '), read(Rainfall),
    write('Enter season: '), read(Season),
    write('Enter location: '), read(Location),
    write('Enter pH level: '), read(PhLevel),
    write('Enter nitrogen level: '), read(Nitrogen),
    write('Enter phosphorous level: '), read(Phosphorous),
    write('Enter potassium level: '), read(Potassium),
    write('Enter soil type: '), read(SoilType),
    write('Enter organic matter: '), read(OrganicMatter),
    write('Enter soil moisture: '), read(SoilMoisture),
    write('Enter electrical conductivity: '), read(ElectricalConductivity),
    write('Enter preferred fertilizer type: '), read(PreferredFertilizerType),
    write('Enter preferred application method: '), read(PreferredApplicationMethod),

    % Get fertilizer recommendation based on inputs
    recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation),
    
    % Output the recommendation
    write('Fertilizer Recommendation: '), nl,
    write('Fertilizer Type: '), write(Recommendation), nl,
    write('NPK Ratio: '), write(Recommendation), nl,
    write('Application Method: '), write(Recommendation), nl,
    write('Frequency: '), write(Recommendation), nl,
    write('Reasoning: '), write(Recommendation), nl.
