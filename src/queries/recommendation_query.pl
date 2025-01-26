% Recommendation for fertilizer based on crop conditions
recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation) :-
    % Match the conditions for fertilizer recommendation
    match_conditions(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod),
    % Generate fertilizer recommendation based on matched conditions
    generate_recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation).

% Match the conditions for fertilizer recommendation
match_conditions(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod) :-
    valid_crop_type(CropType),
    valid_growth_stage(GrowthStage),
    valid_yield_target(YieldTarget),
    valid_fertilizer_history(FertilizerHistory),
    valid_water_requirements(WaterRequirements),
    valid_temperature(Temperature),
    valid_humidity(Humidity),
    valid_rainfall(Rainfall),
    valid_season(Season),
    valid_location(Location),
    valid_ph_level(PhLevel),
    valid_nitrogen(Nitrogen),
    valid_phosphorous(Phosphorous),
    valid_potassium(Potassium),
    valid_soil_type(SoilType),
    valid_organic_matter(OrganicMatter),
    valid_soil_moisture(SoilMoisture),
    valid_electrical_conductivity(ElectricalConductivity),
    valid_preferred_fertilizer_type(PreferredFertilizerType),
    valid_preferred_application_method(PreferredApplicationMethod).

% Generate fertilizer recommendation based on conditions
generate_recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation) :-
    % Default fertilizer type recommendation
    default_fertilizer_type(FertilizerType),
    % Default NPK ratio recommendation
    default_npk_ratio(Nitrogen, Phosphorous, Potassium, NPK),
    % Default application method and frequency
    default_application_method(PreferredApplicationMethod, ApplicationMode),
    default_application_frequency(Frequency),
    % Reasoning for recommendation
    default_reasoning(Reasoning),
    % Construct the full recommendation
    Recommendation = recommendation(fertilizerType(FertilizerType), npk(NPK), applicationMode(ApplicationMode), frequency(Frequency), reasoning(Reasoning)).

% Default fertilizer type based on conditions
default_fertilizer_type(NPK).

% Default NPK ratio recommendation based on nitrogen, phosphorous, and potassium
default_npk_ratio(low, low, low, npk(ratio(1, 1, 1))).
default_npk_ratio(moderate, moderate, moderate, npk(ratio(2, 1, 1))).
default_npk_ratio(high, high, high, npk(ratio(3, 1, 1))).
default_npk_ratio(veryHigh, veryHigh, veryHigh, npk(ratio(4, 1, 1))).

% Default application method and frequency
default_application_method(broadcasting).
default_application_frequency(every2weeks).

% Default reasoning for recommendation
default_reasoning([ "General fertilizer recommendation based on input conditions." ]).
