:- set_prolog_flag(singletons, off).

% Import the fact files (soil facts split by crop type, and other fact files)
:- consult('../facts/crop_facts.pl').         % Import crop facts
:- consult('../facts/environmental_facts.pl').  % Import environment facts
:- consult('../facts/soil_facts/cereal_soil_facts.pl').  % Import soil facts for cereal (replace with your actual files)
:- consult('../facts/soil_facts/vegetable_soil_facts.pl').  % Import soil facts for vegetables (replace with your actual files)
:- consult('../facts/soil_facts/fruit_soil_facts.pl').  % Import soil facts for fruits (replace with your actual files)
:- consult('../facts/soil_facts/legume_soil_facts.pl').  % Import soil facts for legumes (replace with your actual files)
:- consult('../facts/soil_facts/oilseed_soil_facts.pl').  % Import soil facts for oilseeds (replace with your actual files)
:- consult('../facts/soil_facts/tuber_soil_facts.pl').  % Import soil facts for tubers (replace with your actual files)






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
recommend_fertilizer(_CropType, _GrowthStage, _YieldTarget, _FertilizerHistory, _WaterRequirement, _SoilType, _PhLevel, _Nitrogen, _Phosphorous, _Potassium, _OrganicMatter, _SoilMoisture, _ElectricalConductivity, _Temperature, _Humidity, _Rainfall, _Season, _Location, Recommendation) :-
    % % Check crop facts
    % ( crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement) ->
    %     FactStatus = 'Crop fact found'
    % ;
    %     FactStatus = 'Crop fact NOT found',
    %     fail
    % ),

    % % Check environmental facts
    % ( environment(CropType, Temperature, Humidity, Rainfall, Season, Location) ->
    %     EnvStatus = 'Environment fact found'
    % ;
    %     EnvStatus = 'Environment fact NOT found',
    %     fail
    % ),

    % % Check soil facts
    % ( check_soil_facts(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) ->
    %     SoilStatus = 'Soil fact found'
    % ;
    %     SoilStatus = 'Soil fact NOT found',
    %     fail
    % ),


    % If all facts match, provide a recommendation
    % fertilizer_recommendation(CropType, Nitrogen, Phosphorous, Potassium, SoilType, ApplicationMode, Frequency, Recommendation).
    fertilizer_recommendation(_CropType, _Nitrogen, _Phosphorous, _Potassium, _SoilType, _ApplicationMode, _Frequency, Recommendation).




% Rule for fertilizer recommendation with impracticality checks
recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, Temperature, Humidity, Rainfall, Season, Location, Recommendation) :-
    % Check for impractical conditions
    check_impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity),
    check_impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement),
    check_impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location),

    % If no impracticalities are found, proceed with recommendations
    fertilizer_recommendation(CropType, Nitrogen, Phosphorous, Potassium, SoilType, _ApplicationMode, _Frequency, Recommendation).







% Check for impractical soil conditions
check_impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) :-
    ( impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity) ->
        write("Impractical soil conditions detected."), nl
    ;
        true
    ).

% Check for impractical crop conditions
check_impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement) :-
    ( impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement) ->
        write("Impractical crop conditions detected."), nl
    ;
        true
    ).

% Check for impractical environmental conditions
check_impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location) :-
    ( impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location) ->
        write("Impractical environmental conditions detected."), nl
    ;
        true
    ).

% Expanded fertilizer recommendation rules
fertilizer_recommendation(CropType, Nitrogen, Phosphorous, Potassium, _SoilType, _ApplicationMode, _Frequency, Recommendation) :-
    ( CropType == cereal ->
        ( Nitrogen == high, Phosphorous == high, Potassium == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "10:10:10", "values": {"N": 10, "P": 10, "K": 10}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 30 days",
                "reasoning": ["Cereal crops have high nutrient demand, particularly in the vegetative stage.",
                              "Balanced NPK ratio ensures optimal growth and grain formation.",
                              "Broadcasting allows even distribution over the field."]
            }
        ;
            Nitrogen == moderate, Phosphorous == moderate, Potassium == moderate ->
            Recommendation = {
                "fertilizerType": "Compost",
                "NPK": {"ratio": "Varied", "values": {"N": "Varied", "P": "Varied", "K": "Varied"}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 60 days",
                "reasoning": ["Moderate nutrient demand can be fulfilled with organic compost.",
                              "Compost improves soil texture and water retention.",
                              "Side-dressing focuses nutrient availability to growing plants.",
                              "Promotes long-term soil health."]
            }
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "15:5:10", "values": {"N": 15, "P": 5, "K": 10}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 30 days",
                "reasoning": ["Vegetables require high nitrogen for leaf development and high potassium for flowering and fruiting.",
                              "Fertigation directly supplies nutrients to the root zone, improving uptake.",
                              "Moderate phosphorous ensures proper root development without oversaturation."]
            }
        ;
            Nitrogen == moderate, Phosphorous == low, Potassium == moderate ->
            Recommendation = {
                "fertilizerType": "Organic",
                "NPK": {"ratio": "Varied", "values": {"N": "Varied", "P": "Varied", "K": "Varied"}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 40 days",
                "reasoning": ["Organic fertilizers improve soil microbiota and long-term fertility.",
                              "Low phosphorous requirements can be met with slow-release nutrients.",
                              "Broadcasting ensures consistent soil coverage."]
            }
        )
    ;
    CropType == legume ->
        ( Nitrogen == low, Phosphorous == moderate, Potassium == moderate ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:20:20", "values": {"N": 0, "P": 20, "K": 20}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Legumes fix their own nitrogen; minimal nitrogen supplementation is needed.",
                              "Phosphorous promotes root and nodule development.",
                              "Potassium enhances resistance to diseases and improves pod quality.",
                              "Basal application sets the foundation for growth."]
            }
        )
    ;
    CropType == fruit ->
        ( Nitrogen == high, Phosphorous == high, Potassium == moderate ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:20:10", "values": {"N": 20, "P": 20, "K": 10}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 45 days",
                "reasoning": ["High nitrogen supports vegetative growth, especially in young trees.",
                              "Phosphorous ensures strong roots and better fruit setting.",
                              "Moderate potassium levels support overall plant health.",
                              "Fertigation ensures targeted delivery to deep-rooted crops."]
            }
        )
    ;
    CropType == oilseed ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "10:20:20", "values": {"N": 10, "P": 20, "K": 20}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 30 days",
                "reasoning": ["Oilseeds need high phosphorous for better seed quality.",
                              "Potassium improves oil content and disease resistance.",
                              "Moderate nitrogen supports growth without risking lodging."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:10:20", "values": {"N": 20, "P": 10, "K": 20}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 45 days",
                "reasoning": ["Tuber crops need high potassium for starch synthesis.",
                              "Nitrogen supports vegetative growth and leaf area development.",
                              "Moderate phosphorous aids in root expansion.",
                              "Top-dressing provides nutrients as crops mature."]
            }
        )
    ),
    !. % Prevent fallback execution if successful.

% Default recommendation if no matches
fertilizer_recommendation(_, _, _, _, _, _, _, Recommendation) :-
    Recommendation = {
        "fertilizerType": "",
        "NPK": {"ratio": "", "values": {"N": "", "P": "", "K": ""}, "units": "kg/ha"},
        "applicationMode": "",
        "frequency": "",
        "reasoning": []
    }.
