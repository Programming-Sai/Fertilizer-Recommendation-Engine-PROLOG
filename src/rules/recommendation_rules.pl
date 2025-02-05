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



format_reason_string(ReasonLists, FormattedString) :-
    flatten(ReasonLists, FlatList),      % Flatten nested lists into one list
    exclude(=([]), FlatList, NonEmpty),  % Remove empty lists
    ( NonEmpty = [] -> FormattedString = ""
    ; atomic_list_concat(NonEmpty, ' | ', FormattedString) ).








% Check impractical soil conditions
check_impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, Reasons) :-
    impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, Reason, _Factors),
    Reasons = [Reason].


% Check impractical crop conditions
check_impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, Reasons) :-
    impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, Reason, _Factors),
    Reasons = [Reason].

% Check impractical environmental conditions
check_impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location, Reasons) :-
    impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location, Reason, _Factors),
    Reasons = [Reason].







% Expanded fertilizer recommendation rules
fertilizer_recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, Temperature, Humidity, Rainfall, Season, Location, Recommendation) :-
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
    ;
    % BREAK OFF POINT
    CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == high, Potassium == moderate, WaterRequirements == high, SoilType == loamy, PhLevel == neutral ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:10:20", "values": {"N": 20, "P": 10, "K": 20}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 25 days",
                "reasoning": ["Vegetables require high nitrogen for rapid vegetative growth.",
                              "High phosphorous supports root development and flower initiation.",
                              "Potassium is essential for disease resistance and fruit quality.",
                              "Loamy soil with neutral pH ensures optimal nutrient availability for vegetables.",
                              "Frequent fertigation maximizes nutrient uptake during high water demand."]
            }
        )
    ;
    CropType == fruit ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == high, Temperature == moderate, WaterRequirements == moderate, OrganicMatter == moderate ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "15:20:25", "values": {"N": 15, "P": 20, "K": 25}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 40 days",
                "reasoning": ["Moderate nitrogen helps promote balanced vegetative growth in fruiting plants.",
                              "High phosphorous encourages strong root system and fruit set.",
                              "High potassium aids in fruit development, sugar accumulation, and disease resistance.",
                              "Side-dressing ensures nutrient availability as the plant matures and produces fruit.",
                              "Moderate organic matter helps in nutrient release and maintains soil fertility."]
            }
        )
    % ).
    ;
    CropType == legume ->
        ( Nitrogen == low, Phosphorous == moderate, Potassium == low, PhLevel == slightlyAcidic, SoilType == sandy, Season == dry ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:15:10", "values": {"N": 0, "P": 15, "K": 10}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Legumes fix their own nitrogen; thus, minimal nitrogen is required.",
                              "Moderate phosphorous supports root and nodule development, essential in slightly acidic soils.",
                              "Low potassium demand suits legumes as they grow in sandy soils with lower fertility.",
                              "Basal application provides a steady nutrient supply during the crucial early growth phase.",
                              "Dry season conditions necessitate a nutrient plan that adapts to lower rainfall."]
            }
        )
    ;
    CropType == oilseed ->
        ( Nitrogen == high, Phosphorous == high, Potassium == high, PhLevel == alkaline, SoilMoisture == high, Location == tropical ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:20:20", "values": {"N": 20, "P": 20, "K": 20}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 30 days",
                "reasoning": ["Oilseeds thrive with balanced levels of nitrogen, phosphorous, and potassium.",
                              "Alkaline soils require balanced fertilizer to avoid nutrient deficiencies.",
                              "Tropical locations with high moisture require regular applications for optimal growth.",
                              "Broadcasting ensures even distribution across the field, ideal for large areas.",
                              "Oilseeds benefit from high nutrient availability throughout their growth stages."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == low, Phosphorous == high, Potassium == high, SoilMoisture == moderate, PhLevel == neutral, WaterRequirements == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "10:25:20", "values": {"N": 10, "P": 25, "K": 20}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 35 days",
                "reasoning": ["Tuber crops require high potassium to stimulate tuber formation and growth.",
                              "High phosphorous is vital for root expansion and early tuber initiation.",
                              "Moderate soil moisture ensures that nutrients are available for uptake.",
                              "Neutral pH levels promote efficient nutrient absorption for tuber crops.",
                              "Regular top-dressing allows for timely nutrient replenishment during the growing season."]
            }
        )
    ;
    CropType == cereal ->
        ( Nitrogen == veryHigh, Phosphorous == moderate, Potassium == high, Season == summer, SoilType == sandy, PhLevel == slightlyAlkaline ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "30:10:20", "values": {"N": 30, "P": 10, "K": 20}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 20 days",
                "reasoning": ["Cereal crops have a high nitrogen demand, especially during the vegetative stage.",
                              "Moderate phosphorous is essential for root development and flowering.",
                              "High potassium is important for improving grain quality and disease resistance.",
                              "Slightly alkaline pH and sandy soils favor nutrient availability and drainage.",
                              "Summer season conditions require frequent fertilizer application to meet the plants high nutrient demand."]
            }
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == moderate, PhLevel == acidic, SoilMoisture == high, Season == wet ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "15:25:15", "values": {"N": 15, "P": 25, "K": 15}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 20 days",
                "reasoning": ["Moderate nitrogen supports balanced leaf growth while avoiding excessive vegetative growth.",
                              "High phosphorous ensures strong root system development in acidic soils.",
                              "High potassium is necessary for optimal flowering and fruiting in wet conditions.",
                              "Fertigation ensures efficient nutrient uptake during the rainy season when water availability is high.",
                              "Consistent fertigation provides nutrients directly to the root zone for rapid absorption."]
            }
        )
    ;
    CropType == legume ->
        ( Nitrogen == low, Phosphorous == high, Potassium == moderate, PhLevel == neutral, SoilType == loamy, OrganicMatter == high ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:25:15", "values": {"N": 0, "P": 25, "K": 15}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "once at flowering",
                "reasoning": ["Legumes fix nitrogen, so high nitrogen fertilizers are not necessary.",
                              "High phosphorous is critical for root and nodule development in neutral loamy soils.",
                              "Moderate potassium promotes disease resistance and pod quality during flowering.",
                              "Side-dressing provides targeted nutrition to support plant needs during the reproductive phase.",
                              "High organic matter improves soil structure and nutrient retention, enhancing fertilizer efficacy."]
            }
        )
    ;
        CropType == fruit ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == high, SoilMoisture == moderate, PhLevel == neutral, Season == autumn ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "18:22:20", "values": {"N": 18, "P": 22, "K": 20}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 40 days",
                "reasoning": ["Moderate nitrogen encourages balanced growth and flowering.",
                              "High phosphorous promotes strong root system and fruit set.",
                              "High potassium supports fruit size, sugar accumulation, and disease resistance.",
                              "Side-dressing is effective in maintaining nutrient levels during the fruiting phase.",
                              "Autumn season requires adjustments for optimal nutrient uptake under cooler conditions."]
            }
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high, Temperature == hot, PhLevel == slightlyAlkaline, WaterRequirements == veryHigh ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "25:10:25", "values": {"N": 25, "P": 10, "K": 25}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 15 days",
                "reasoning": ["High nitrogen supports rapid vegetative growth, which is essential in hot temperatures.",
                              "Moderate phosphorous encourages root development, important for vegetable stability.",
                              "High potassium is required to support plant resistance to high temperatures and ensure fruiting.",
                              "Fertigation is recommended in areas with very high water demand to enhance nutrient uptake.",
                              "Slightly alkaline pH enhances the availability of essential nutrients."]
            }
        )
    ;
    CropType == cereal ->
        ( Nitrogen == low, Phosphorous == high, Potassium == moderate, SoilType == clay, PhLevel == acidic, OrganicMatter == moderate ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:30:20", "values": {"N": 0, "P": 30, "K": 20}, "units": "kg/ha"},
                "applicationMode": "broadcasting",
                "frequency": "every 30 days",
                "reasoning": ["Low nitrogen requirement due to nitrogen fixation and natural soil nutrients.",
                              "High phosphorous supports root growth and tillering in clay soils.",
                              "Moderate potassium helps with resistance to diseases, especially in acidic soils.",
                              "Clay soils high nutrient retention benefits broadcasting methods for consistent fertilizer distribution.",
                              "Moderate organic matter levels improve soil structure, providing better aeration and drainage."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high, SoilMoisture == high, Temperature == moderate, PhLevel == neutral ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:15:25", "values": {"N": 20, "P": 15, "K": 25}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 25 days",
                "reasoning": ["High nitrogen supports rapid vegetative growth during the tuber development phase.",
                              "Moderate phosphorous helps with tuber initiation and overall root health.",
                              "High potassium promotes tuber growth, quality, and size.",
                              "Top-dressing helps maintain nutrient availability during tuber bulking.",
                              "High soil moisture and neutral pH create optimal conditions for nutrient uptake."]
            }
        )
    ;
    CropType == oilseed ->
        ( Nitrogen == low, Phosphorous == high, Potassium == high, Season == summer, Location == arid, OrganicMatter == low ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:30:25", "values": {"N": 0, "P": 30, "K": 25}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Oilseeds require minimal nitrogen but benefit from high phosphorous for early development.",
                              "High potassium supports drought resistance and improves oil content in arid conditions.",
                              "Basal application is ideal for ensuring sufficient nutrients during the dry season.",
                              "Low organic matter in arid locations can limit nutrient retention, so high potassium and phosphorous are essential."]
            }
        )
    ;
    CropType == legume ->
        ( Nitrogen == low, Phosphorous == high, Potassium == moderate, SoilType == peat, PhLevel == acidic, OrganicMatter == high ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:25:20", "values": {"N": 0, "P": 25, "K": 20}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Legumes naturally fix nitrogen, so no additional nitrogen is required.",
                              "High phosphorous supports strong root and nodule development in acidic peat soils.",
                              "Moderate potassium helps with disease resistance and promotes overall plant health.",
                              "Basal application ensures a balanced nutrient supply during the critical early growth stage.",
                              "High organic matter in peat soils aids in nutrient retention and improved soil structure."]
            }
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high, PhLevel == slightlyAlkaline, SoilMoisture == high, Rainfall == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "25:15:25", "values": {"N": 25, "P": 15, "K": 25}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 10 days",
                "reasoning": ["High nitrogen promotes rapid growth, which is needed for vegetables during their active growth phase.",
                              "Moderate phosphorous helps with root and flower development, even under high rainfall.",
                              "High potassium supports disease resistance and fruit quality.",
                              "Fertigation is ideal for high moisture conditions, as it ensures efficient nutrient uptake through the roots.",
                              "Slightly alkaline soils are well suited for the nutrient uptake needed in this setup."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == moderate, SoilType == clay, OrganicMatter == high, WaterRequirements == moderate ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "15:30:20", "values": {"N": 15, "P": 30, "K": 20}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 20 days",
                "reasoning": ["Moderate nitrogen ensures balanced vegetative growth during the tuber development phase.",
                              "High phosphorous is necessary for root system development and tuber initiation.",
                              "Moderate potassium helps with tuber bulking and improves disease resistance.",
                              "Top-dressing provides consistent nutrient availability during the tuber bulking phase.",
                              "High organic matter improves soil structure, ensuring better moisture retention in clay soils."]
            }
        )
    ;
    CropType == oilseed ->
        ( Nitrogen == low, Phosphorous == high, Potassium == high, Temperature == cool, SoilType == sandy, OrganicMatter == moderate ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:30:25", "values": {"N": 0, "P": 30, "K": 25}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 30 days",
                "reasoning": ["Oilseeds do not require high nitrogen, as they benefit more from phosphorous and potassium.",
                              "High phosphorous promotes strong root and nodule development in cool temperatures.",
                              "High potassium improves disease resistance and oil content in sandy soils.",
                              "Side-dressing allows for targeted nutrient application as the plant matures.",
                              "Moderate organic matter helps with nutrient retention in sandy soils."]
            }
        )
    ;
        CropType == vegetable ->
        ( Nitrogen == high, Phosphorous == high, Potassium == moderate, SoilType == loamy, PhLevel == neutral, OrganicMatter == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "25:20:15", "values": {"N": 25, "P": 20, "K": 15}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 20 days",
                "reasoning": ["High nitrogen encourages rapid growth during the vegetative stage.",
                              "High phosphorous promotes root development and flowering.",
                              "Moderate potassium helps in disease resistance and fruit quality.",
                              "Loamy soil with high organic matter allows efficient nutrient uptake.",
                              "Side-dressing every 20 days ensures consistent nutrient supply during growth."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == low, Phosphorous == high, Potassium == high, SoilType == silt, PhLevel == slightlyAcidic, OrganicMatter == moderate ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "0:35:25", "values": {"N": 0, "P": 35, "K": 25}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Low nitrogen is sufficient for tubers as they have low nitrogen demand.",
                              "High phosphorous is crucial for tuber initiation and root development.",
                              "High potassium promotes tuber quality and helps the plant resist stress.",
                              "Silt soil with moderate organic matter provides excellent nutrient retention.",
                              "Basal application at planting is effective in establishing strong tuber growth."]
            }
        )
    ;
    CropType == fruit ->
        ( Nitrogen == low, Phosphorous == high, Potassium == high, SoilMoisture == moderate, PhLevel == neutral, Rainfall == moderate ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "0:35:30", "values": {"N": 0, "P": 35, "K": 30}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 25 days",
                "reasoning": ["Low nitrogen helps focus on fruiting rather than excessive vegetative growth.",
                              "High phosphorous supports strong root and fruit development.",
                              "High potassium ensures fruit size, sugar content, and resistance to diseases.",
                              "Moderate soil moisture and rainfall create ideal conditions for nutrient uptake.",
                              "Side-dressing every 25 days keeps nutrient levels balanced during fruit development."]
            }
        )
    ;
    CropType == oilseed ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == low, SoilType == clay, PhLevel == slightlyAlkaline, OrganicMatter == moderate ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "15:30:10", "values": {"N": 15, "P": 30, "K": 10}, "units": "kg/ha"},
                "applicationMode": "fertigation",
                "frequency": "every 30 days",
                "reasoning": ["Moderate nitrogen supports balanced growth without excessive vegetative growth.",
                              "High phosphorous promotes root and nodule development.",
                              "Low potassium prevents excessive plant stress while still promoting oil content.",
                              "Clay soil helps retain nutrients, and slightly alkaline pH is optimal for nutrient uptake.",
                              "Fertigation ensures consistent nutrient availability in this setup."]
            }
        )
    ;
    CropType == cereal ->
        ( Nitrogen == moderate, Phosphorous == low, Potassium == high, SoilMoisture == high, PhLevel == neutral, Rainfall == high ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:5:30", "values": {"N": 20, "P": 5, "K": 30}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 15 days",
                "reasoning": ["Moderate nitrogen supports steady growth and grain filling.",
                              "Low phosphorous is acceptable as long as potassium is high, preventing excessive vegetative growth.",
                              "High potassium promotes drought resistance and overall plant health during high rainfall.",
                              "Top-dressing every 15 days ensures that the crop gets adequate nutrients during the critical grain-filling period."]
            }
        )
    ;
    CropType == vegetable ->
        ( Nitrogen == low, Phosphorous == high, Potassium == moderate, Temperature == moderate, PhLevel == slightlyAcidic, SoilMoisture == moderate ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "0:40:20", "values": {"N": 0, "P": 40, "K": 20}, "units": "kg/ha"},
                "applicationMode": "basal application",
                "frequency": "once at planting",
                "reasoning": ["Low nitrogen is ideal for vegetables with low nitrogen requirements.",
                              "High phosphorous supports root and flower development.",
                              "Moderate potassium helps prevent disease and improve fruit quality.",
                              "Moderate soil moisture and slightly acidic pH help with nutrient uptake during early growth."]
            }
        )
    ;
    CropType == legume ->
        ( Nitrogen == moderate, Phosphorous == high, Potassium == moderate, SoilType == chalky, PhLevel == slightlyAlkaline, OrganicMatter == high ->
            Recommendation = {
                "fertilizerType": "P-K Blend",
                "NPK": {"ratio": "10:35:15", "values": {"N": 10, "P": 35, "K": 15}, "units": "kg/ha"},
                "applicationMode": "top-dressing",
                "frequency": "every 30 days",
                "reasoning": ["Moderate nitrogen boosts growth without compromising nodule development.",
                              "High phosphorous supports root growth and nodule fixation.",
                              "Moderate potassium helps with disease resistance and root development.",
                              "Chalky soil with high organic matter ensures nutrient retention and proper aeration."]
            }
        )
    ;
    CropType == tuber ->
        ( Nitrogen == high, Phosphorous == moderate, Potassium == high, SoilType == sandy, PhLevel == alkaline, OrganicMatter == low ->
            Recommendation = {
                "fertilizerType": "NPK",
                "NPK": {"ratio": "20:15:30", "values": {"N": 20, "P": 15, "K": 30}, "units": "kg/ha"},
                "applicationMode": "side-dressing",
                "frequency": "every 15 days",
                "reasoning": ["High nitrogen ensures that the plant has enough vegetative growth to support tuber development.",
                              "Moderate phosphorous promotes tuber initiation, especially in sandy, alkaline soils.",
                              "High potassium helps to improve tuber yield and quality.",
                              "Side-dressing every 15 days helps maintain nutrient levels during tuber bulking."]
            }
        )

    ),
    !. % Prevent fallback execution if successful.


    


recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, 
                     SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, 
                     SoilMoisture, ElectricalConductivity, Temperature, Humidity, Rainfall, 
                     Season, Location, ImpracticalReasons, Recommendation) :-

    % Run all checks without stopping
    ( check_impractical_soil(CropType, SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, SoilMoisture, ElectricalConductivity, SoilReasons)
    -> true ; SoilReasons = [] ),

    ( check_impractical_crop(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, CropReasons)
    -> true ; CropReasons = [] ),

    ( check_impractical_environment(CropType, Temperature, Humidity, Rainfall, Season, Location, EnvReasons)
    -> true ; EnvReasons = [] ),

    % Convert reasons into a single formatted string
    format_reason_string([SoilReasons, CropReasons, EnvReasons], ImpracticalReasons),

    ( 
      % If there are impractical conditions, return them directly

      ImpracticalReasons \= "" ->
      atom_string(ImpracticalReasons, ReasonStr),  
        Recommendation = {
            "fertilizerType": "",
            "NPK": {"ratio": "", "values": {"N": "", "P": "", "K": ""}, "units": "kg/ha"},
            "applicationMode": "",
            "frequency": "",
            "reasoning": [ReasonStr]
        }
    ;
      % Otherwise, try fertilizer recommendation
      ( 
        fertilizer_recommendation(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirement, 
                                  SoilType, PhLevel, Nitrogen, Phosphorous, Potassium, OrganicMatter, 
                                  SoilMoisture, ElectricalConductivity, Temperature, Humidity, Rainfall, 
                                  Season, Location, Recommendation) 
      -> true 
      ; 
        % Default fallback recommendation if no match found
        Recommendation = {
            "fertilizerType": "General-Purpose Fertilizer",
            "NPK": {"ratio": "10:10:10", "values": {"N": "10", "P": "10", "K": "10"}, "units": "kg/ha"},
            "applicationMode": "broadcast",
            "frequency": "every 60 days",
            "reasoning": ["No specific recommendation found, using a balanced general-purpose fertilizer."]
        }
      )
    ).



% 






