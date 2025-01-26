% Water Requirements for Environments
water_requirement(cereal, moderate).
water_requirement(vegetable, high).
water_requirement(legume, moderate).
water_requirement(fruit, moderate).
water_requirement(oilseed, low).
water_requirement(tuber, moderate).

% Temperature Preferences for Environments
temperature(cereal, cool).
temperature(vegetable, moderate).
temperature(legume, moderate).
temperature(fruit, hot).
temperature(oilseed, cool).
temperature(tuber, cool).

% Humidity Preferences for Environments
humidity(cereal, moderate).
humidity(vegetable, high).
humidity(legume, moderate).
humidity(fruit, moderate).
humidity(oilseed, low).
humidity(tuber, high).

% Rainfall Preferences for Environments
rainfall(cereal, moderate).
rainfall(vegetable, high).
rainfall(legume, moderate).
rainfall(fruit, moderate).
rainfall(oilseed, low).
rainfall(tuber, moderate).

% Season Preferences for Environments
season(cereal, winter).
season(vegetable, spring).
season(legume, summer).
season(fruit, autumn).
season(oilseed, spring).
season(tuber, winter).

% Location Preferences for Environments
location(cereal, temperate).
location(vegetable, tropical).
location(legume, arid).
location(fruit, tropical).
location(oilseed, temperate).
location(tuber, temperate).

% pH Level Preferences for Environments
ideal_ph(cereal, neutral).
ideal_ph(vegetable, slightly_alkaline).
ideal_ph(legume, slightly_acidic).
ideal_ph(fruit, slightly_alkaline).
ideal_ph(oilseed, neutral).
ideal_ph(tuber, slightly_acidic).

% Nitrogen Requirements for Environments
nitrogen(cereal, moderate).
nitrogen(vegetable, high).
nitrogen(legume, low).
nitrogen(fruit, high).
nitrogen(oilseed, moderate).
nitrogen(tuber, moderate).

% Phosphorous Requirements for Environments
phosphorous(cereal, moderate).
phosphorous(vegetable, high).
phosphorous(legume, moderate).
phosphorous(fruit, moderate).
phosphorous(oilseed, moderate).
phosphorous(tuber, low).

% Potassium Requirements for Environments
potassium(cereal, high).
potassium(vegetable, moderate).
potassium(legume, moderate).
potassium(fruit, high).
potassium(oilseed, moderate).
potassium(tuber, moderate).

% Soil Types for Environments
soil_type(cereal, loamy).
soil_type(vegetable, loamy).
soil_type(legume, sandy).
soil_type(fruit, loamy).
soil_type(oilseed, sandy).
soil_type(tuber, loamy).

% Organic Matter Preferences for Environments
organic_matter(cereal, moderate).
organic_matter(vegetable, high).
organic_matter(legume, moderate).
organic_matter(fruit, high).
organic_matter(oilseed, moderate).
organic_matter(tuber, moderate).

% Soil Moisture Preferences for Environments
soil_moisture(cereal, moderate).
soil_moisture(vegetable, high).
soil_moisture(legume, moderate).
soil_moisture(fruit, moderate).
soil_moisture(oilseed, low).
soil_moisture(tuber, high).

% Electrical Conductivity Preferences for Environments
electrical_conductivity(cereal, moderate).
electrical_conductivity(vegetable, high).
electrical_conductivity(legume, moderate).
electrical_conductivity(fruit, moderate).
electrical_conductivity(oilseed, low).
electrical_conductivity(tuber, high).

% Preferred Fertilizer Types for Environments
preferred_fertilizer_type(cereal, npk).
preferred_fertilizer_type(vegetable, compost).
preferred_fertilizer_type(legume, organic).
preferred_fertilizer_type(fruit, npk).
preferred_fertilizer_type(oilseed, organic).
preferred_fertilizer_type(tuber, slow_release).

% Preferred Application Methods for Environments
preferred_application_method(cereal, broadcasting).
preferred_application_method(vegetable, fertigation).
preferred_application_method(legume, side_dressing).
preferred_application_method(fruit, broadcasting).
preferred_application_method(oilseed, side_dressing).
preferred_application_method(tuber, fertigation).
