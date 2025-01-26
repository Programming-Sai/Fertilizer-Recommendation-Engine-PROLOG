:- module(utils, [
    validate_crop_type/1,
    validate_growth_stage/1,
    validate_yield_target/1,
    validate_soil_type/1,
    validate_fertilizer_history/1,
    validate_temperature/1,
    validate_water_requirements/1,
    validate_soil_moisture/1,
    recommend_fertilizer/19
]).

% Validation for crop type
validate_crop_type(CropType) :-
    member(CropType, ["cereal", "vegetable", "legume", "fruit", "oilseed", "tuber"]).

% Validation for growth stage
validate_growth_stage(GrowthStage) :-
    member(GrowthStage, ["seedling", "vegetative", "flowering", "fruiting", "harvest"]).

% Validation for yield target
validate_yield_target(YieldTarget) :-
    member(YieldTarget, ["low", "moderate", "high", "slightlyHigh", "veryHigh"]).

% Validation for soil type
validate_soil_type(SoilType) :-
    member(SoilType, ["loamy", "clay", "sandy", "peat", "saline", "chalky", "silt"]).

% Validation for fertilizer history
validate_fertilizer_history(FertilizerHistory) :-
    member(FertilizerHistory, ["none", "low", "moderate", "high"]).

% Validation for temperature
validate_temperature(Temperature) :-
    member(Temperature, ["cold", "cool", "moderate", "hot", "veryHot"]).

% Validation for water requirements
validate_water_requirements(WaterRequirements) :-
    member(WaterRequirements, ["low", "moderate", "high", "veryHigh", "variable"]).

% Validation for soil moisture
validate_soil_moisture(SoilMoisture) :-
    member(SoilMoisture, ["low", "moderate", "high", "veryHigh"]).

% Recommendation logic placeholder based on parameters
recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation) :-
    % Example logic based on crop type and growth stage for demonstration
    (CropType == "cereal", GrowthStage == "vegetative" -> 
        Recommendation = "Use NPK with a ratio of 20:10:10, 100 kg/ha";
        Recommendation = "General recommendation: Apply balanced fertilizer").
