% Rule for Fertilizer Recommendations Based on Conditions
% This rule evaluates different crop conditions and provides appropriate fertilizer recommendations.

% Example rule for cereal crops in the vegetative stage with moderate yield target, moderate water requirement, and moderate nitrogen
recommend_fertilizer(cereal, vegetative, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, NPK, [N=30, P=20, K=20], broadcasting, "every 3 weeks") :-
    water_requirement(cereal, moderate),
    nitrogen(cereal, moderate),
    phosphorous(cereal, moderate),
    potassium(cereal, moderate),
    season(cereal, spring),
    location(cereal, temperate),
    ideal_ph(cereal, neutral),
    soil_type(cereal, loamy),
    organic_matter(cereal, moderate),
    soil_moisture(cereal, moderate),
    electrical_conductivity(cereal, moderate),
    preferred_fertilizer_type(cereal, NPK),
    preferred_application_method(cereal, broadcasting),
    yield_target(cereal, moderate).

% Rule for vegetable crops in the flowering stage with high yield target, high water requirement, and high nitrogen
recommend_fertilizer(vegetable, flowering, high, high, high, high, high, high, high, high, high, high, compost, [], fertigation, "every 2 weeks") :-
    water_requirement(vegetable, high),
    nitrogen(vegetable, high),
    phosphorous(vegetable, high),
    potassium(vegetable, high),
    season(vegetable, summer),
    location(vegetable, tropical),
    ideal_ph(vegetable, slightly_alkaline),
    soil_type(vegetable, loamy),
    organic_matter(vegetable, high),
    soil_moisture(vegetable, high),
    electrical_conductivity(vegetable, high),
    preferred_fertilizer_type(vegetable, compost),
    preferred_application_method(vegetable, fertigation),
    yield_target(vegetable, high).

% Rule for legume crops in the seedling stage with moderate yield target, moderate water requirement, and low nitrogen
recommend_fertilizer(legume, seedling, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, organic, [], side_dressing, "every 4 weeks") :-
    water_requirement(legume, moderate),
    nitrogen(legume, low),
    phosphorous(legume, moderate),
    potassium(legume, moderate),
    season(legume, spring),
    location(legume, arid),
    ideal_ph(legume, slightly_acidic),
    soil_type(legume, sandy),
    organic_matter(legume, moderate),
    soil_moisture(legume, moderate),
    electrical_conductivity(legume, moderate),
    preferred_fertilizer_type(legume, organic),
    preferred_application_method(legume, side_dressing),
    yield_target(legume, moderate).

% Rule for fruit crops in the fruiting stage with very high yield target, high water requirement, and high nitrogen
recommend_fertilizer(fruit, fruiting, veryHigh, high, high, high, high, high, high, high, high, high, NPK, [N=50, P=30, K=30], broadcasting, "every 3 weeks") :-
    water_requirement(fruit, high),
    nitrogen(fruit, high),
    phosphorous(fruit, high),
    potassium(fruit, high),
    season(fruit, autumn),
    location(fruit, tropical),
    ideal_ph(fruit, slightly_alkaline),
    soil_type(fruit, loamy),
    organic_matter(fruit, high),
    soil_moisture(fruit, high),
    electrical_conductivity(fruit, high),
    preferred_fertilizer_type(fruit, NPK),
    preferred_application_method(fruit, broadcasting),
    yield_target(fruit, veryHigh).

% Rule for oilseed crops in the flowering stage with moderate yield target, moderate water requirement, and moderate nitrogen
recommend_fertilizer(oilseed, flowering, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, moderate, slow_release, [], fertigation, "every 6 weeks") :-
    water_requirement(oilseed, moderate),
    nitrogen(oilseed, moderate),
    phosphorous(oilseed, moderate),
    potassium(oilseed, moderate),
    season(oilseed, spring),
    location(oilseed, temperate),
    ideal_ph(oilseed, neutral),
    soil_type(oilseed, sandy),
    organic_matter(oilseed, moderate),
    soil_moisture(oilseed, moderate),
    electrical_conductivity(oilseed, moderate),
    preferred_fertilizer_type(oilseed, slow_release),
    preferred_application_method(oilseed, fertigation),
    yield_target(oilseed, moderate).

% Rule for tuber crops in the harvest stage with low yield target, low water requirement, and low nitrogen
recommend_fertilizer(tuber, harvest, low, low, low, low, low, low, low, low, low, low, compost, [], side_dressing, "every 8 weeks") :-
    water_requirement(tuber, low),
    nitrogen(tuber, low),
    phosphorous(tuber, low),
    potassium(tuber, low),
    season(tuber, winter),
    location(tuber, temperate),
    ideal_ph(tuber, slightly_acidic),
    soil_type(tuber, loamy),
    organic_matter(tuber, low),
    soil_moisture(tuber, low),
    electrical_conductivity(tuber, low),
    preferred_fertilizer_type(tuber, compost),
    preferred_application_method(tuber, side_dressing),
    yield_target(tuber, low).
