% Knowledge base for fertilizer recommendations
% Format:
% recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements,
%                Temperature, Humidity, Rainfall, Season, Location, PhLevel,
%                Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter,
%                SoilMoisture, ElectricalConductivity, PreferredFertilizerType, 
%                PreferredApplicationMethod, FertilizerType, NPKRatio, ApplicationMode, Frequency, Reasoning).

% Define possible conditions
crop_type(cereal).
crop_type(vegetable).
crop_type(legume).
crop_type(fruit).
crop_type(oilseed).
crop_type(tuber).

growth_stage(seedling).
growth_stage(vegetative).
growth_stage(flowering).
growth_stage(fruiting).
growth_stage(harvest).

yield_target(low).
yield_target(moderate).
yield_target(high).
yield_target(slightlyHigh).
yield_target(veryHigh).

fertilizer_history(none).
fertilizer_history(low).
fertilizer_history(moderate).
fertilizer_history(high).

water_requirements(low).
water_requirements(moderate).
water_requirements(high).
water_requirements(veryHigh).
water_requirements(variable).

temperature(cold).
temperature(cool).
temperature(moderate).
temperature(hot).
temperature(veryHot).

humidity(low).
humidity(moderate).
humidity(high).
humidity(veryHigh).
humidity(extreme).

rainfall(low).
rainfall(moderate).
rainfall(high).
rainfall(veryHigh).
rainfall(variable).

season(spring).
season(summer).
season(autumn).
season(winter).
season(wet).
season(dry).

location(tropical).
location(temperate).
location(arid).
location(mountainous).
location(coastal).

ph_level(acidic).
ph_level(neutral).
ph_level(alkaline).
ph_level(slightlyAcidic).
ph_level(slightlyAlkaline).

nitrogen(low).
nitrogen(moderate).
nitrogen(high).
nitrogen(veryHigh).

phosphorous(low).
phosphorous(moderate).
phosphorous(high).
phosphorous(veryHigh).

potassium(low).
potassium(moderate).
potassium(high).
potassium(veryHigh).

soil_type(loamy).
soil_type(clay).
soil_type(sandy).
soil_type(peat).
soil_type(saline).
soil_type(chalky).
soil_type(silt).

organic_matter(low).
organic_matter(moderate).
organic_matter(high).
organic_matter(veryHigh).

soil_moisture(low).
soil_moisture(moderate).
soil_moisture(high).
soil_moisture(veryHigh).

electrical_conductivity(low).
electrical_conductivity(moderate).
electrical_conductivity(high).
electrical_conductivity(veryHigh).
electrical_conductivity(extreme).

prefered_fertilizer_type(NPK).
prefered_fertilizer_type(compost).
prefered_fertilizer_type(organic).
prefered_fertilizer_type(slow_release).

prefered_application_method(broadcasting).
prefered_application_method(fertigation).
prefered_application_method(side_dressing).

% Define generalized recommendation rule
recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements,
               Temperature, Humidity, Rainfall, Season, Location, PhLevel,
               Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter,
               SoilMoisture, ElectricalConductivity, PreferredFertilizerType, 
               PreferredApplicationMethod, FertilizerType, NPKRatio, ApplicationMode, Frequency, Reasoning) :-
    crop_recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, 
                        Temperature, Humidity, Rainfall, Season, Location, PhLevel, 
                        Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, 
                        SoilMoisture, ElectricalConductivity, PreferredFertilizerType, 
                        PreferredApplicationMethod, FertilizerType, NPKRatio, ApplicationMode, Frequency, Reasoning).

% Specific fertilizer recommendation for each combination of conditions
crop_recommendation(cereal, vegetative, high, moderate, high, moderate, high, moderate, spring, temperate, neutral, moderate, high, moderate, loamy, high, moderate, moderate, NPK, broadcasting, "every 2 weeks", 
    [
        "High nitrogen requirement to support vegetative growth and strong leaf/stem development.",
        "Moderate phosphorous for efficient root growth and nutrient uptake.",
        "Moderate potassium to aid in strong root development and stress resistance."
    ]).

crop_recommendation(vegetable, flowering, moderate, low, moderate, cool, high, high, summer, coastal, acidic, high, moderate, high, sandy, moderate, high, high, compost, side_dressing, "every 3 weeks", 
    [
        "High nitrogen required for flowering and leaf expansion.",
        "Moderate phosphorous supports strong flower and fruit formation.",
        "High potassium for root growth and overall plant health."
    ]).

crop_recommendation(fruit, fruiting, veryHigh, high, high, hot, high, veryHigh, autumn, tropical, alkaline, veryHigh, high, veryHigh, peat, high, high, extreme, NPK, fertigation, "every week", 
    [
        "High potassium supports fruit quality and development.",
        "High phosphorus for flower-to-fruit transition and strong fruit set.",
        "Moderate nitrogen to maintain balanced growth without excessive vegetative growth."
    ]).

crop_recommendation(oilseed, seedling, low, none, variable, cold, low, low, winter, mountainous, neutral, moderate, low, low, clay, moderate, low, low, slow_release, broadcasting, "every 4 weeks", 
    [
        "Low nitrogen for initial seedling development without promoting excessive growth.",
        "Balanced NPK to support seedling establishment and root development.",
        "Slow-release fertilizer provides steady nutrient availability over time."
    ]).

% More rules for different crop types, growth stages, and other conditions

crop_recommendation(legume, vegetative, moderate, moderate, moderate, cool, moderate, moderate, spring, temperate, neutral, moderate, high, moderate, loamy, high, moderate, moderate, NPK, broadcasting, "every 3 weeks", 
    [
        "Moderate nitrogen due to nitrogen fixation abilities of legumes.",
        "Moderate phosphorous supports root growth and flowering.",
        "Moderate potassium enhances disease resistance and root development."
    ]).

crop_recommendation(tuber, flowering, high, high, high, hot, moderate, low, summer, arid, neutral, high, moderate, high, sandy, moderate, high, low, organic, side_dressing, "every 2 weeks", 
    [
        "High nitrogen needed for tuber growth and energy for flowering.",
        "Moderate potassium and phosphorous for tuber formation and healthy roots.",
        "Organic fertilizer enhances soil structure and moisture retention."
    ]).

crop_recommendation(legume, flowering, high, moderate, moderate, cool, moderate, moderate, spring, temperate, neutral, moderate, high, moderate, loamy, high, moderate, moderate, NPK, broadcasting, "every 3 weeks", 
    [
        "Moderate nitrogen to support legume flowering, as nitrogen is fixed by the plant.",
        "Moderate phosphorous for strong root and flower development.",
        "Moderate potassium for balanced plant health and fruit production."
    ]).

crop_recommendation(oilseed, vegetative, high, low, high, cool, moderate, moderate, spring, temperate, neutral, moderate, moderate, high, loamy, high, moderate, high, NPK, broadcasting, "every 3 weeks", 
    [
        "Moderate nitrogen for vegetative growth and leaf expansion.",
        "Moderate phosphorous for strong root development and flower formation.",
        "High potassium for overall plant health and disease resistance."
    ]).

% Add more rules as required for each crop type and condition.
