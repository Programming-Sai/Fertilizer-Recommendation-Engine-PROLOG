% Validation rule for crop type
valid_crop_type(cereal).
valid_crop_type(vegetable).
valid_crop_type(legume).
valid_crop_type(fruit).
valid_crop_type(oilseed).
valid_crop_type(tuber).

% Validation rule for growth stage
valid_growth_stage(seedling).
valid_growth_stage(vegetative).
valid_growth_stage(flowering).
valid_growth_stage(fruiting).
valid_growth_stage(harvest).

% Validation rule for yield target
valid_yield_target(low).
valid_yield_target(moderate).
valid_yield_target(high).
valid_yield_target(slightlyHigh).
valid_yield_target(veryHigh).

% Validation rule for fertilizer history
valid_fertilizer_history(none).
valid_fertilizer_history(low).
valid_fertilizer_history(moderate).
valid_fertilizer_history(high).

% Validation rule for water requirements
valid_water_requirements(low).
valid_water_requirements(moderate).
valid_water_requirements(high).
valid_water_requirements(veryHigh).
valid_water_requirements(variable).

% Validation rule for temperature
valid_temperature(cold).
valid_temperature(cool).
valid_temperature(moderate).
valid_temperature(hot).
valid_temperature(veryHot).

% Validation rule for humidity
valid_humidity(low).
valid_humidity(moderate).
valid_humidity(high).
valid_humidity(veryHigh).
valid_humidity(extreme).

% Validation rule for rainfall
valid_rainfall(low).
valid_rainfall(moderate).
valid_rainfall(high).
valid_rainfall(veryHigh).
valid_rainfall(variable).

% Validation rule for season
valid_season(spring).
valid_season(summer).
valid_season(autumn).
valid_season(winter).
valid_season(wet).
valid_season(dry).

% Validation rule for location
valid_location(tropical).
valid_location(temperate).
valid_location(arid).
valid_location(mountainous).
valid_location(coastal).

% Validation rule for pH level
valid_ph_level(acidic).
valid_ph_level(neutral).
valid_ph_level(alkaline).
valid_ph_level(slightlyAcidic).
valid_ph_level(slightlyAlkaline).

% Validation rule for nitrogen
valid_nitrogen(low).
valid_nitrogen(moderate).
valid_nitrogen(high).
valid_nitrogen(veryHigh).

% Validation rule for phosphorous
valid_phosphorous(low).
valid_phosphorous(moderate).
valid_phosphorous(high).
valid_phosphorous(veryHigh).

% Validation rule for potassium
valid_potassium(low).
valid_potassium(moderate).
valid_potassium(high).
valid_potassium(veryHigh).

% Validation rule for soil type
valid_soil_type(loamy).
valid_soil_type(clay).
valid_soil_type(sandy).
valid_soil_type(peat).
valid_soil_type(saline).
valid_soil_type(chalky).
valid_soil_type(silt).

% Validation rule for organic matter
valid_organic_matter(low).
valid_organic_matter(moderate).
valid_organic_matter(high).
valid_organic_matter(veryHigh).

% Validation rule for soil moisture
valid_soil_moisture(low).
valid_soil_moisture(moderate).
valid_soil_moisture(high).
valid_soil_moisture(veryHigh).

% Validation rule for electrical conductivity
valid_electrical_conductivity(low).
valid_electrical_conductivity(moderate).
valid_electrical_conductivity(high).
valid_electrical_conductivity(veryHigh).
valid_electrical_conductivity(extreme).

% Validation rule for preferred fertilizer type
valid_preferred_fertilizer_type(NPK).
valid_preferred_fertilizer_type(compost).
valid_preferred_fertilizer_type(organic).
valid_preferred_fertilizer_type(slow-release).

% Validation rule for preferred application method
valid_preferred_application_method(broadcasting).
valid_preferred_application_method(fertigation).
valid_preferred_application_method(side_dressing).

% Rule to validate the entire fertilizer recommendation request
validate_fertilizer_request(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod) :-
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
