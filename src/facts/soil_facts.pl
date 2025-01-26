% Soil Types
soil_type(loamy).
soil_type(clay).
soil_type(sandy).
soil_type(peat).
soil_type(saline).
soil_type(chalky).
soil_type(silt).

% pH Levels for Different Soil Types
ideal_ph(loamy, neutral).
ideal_ph(clay, slightly_acidic).
ideal_ph(sandy, slightly_alkaline).
ideal_ph(peat, acidic).
ideal_ph(saline, alkaline).
ideal_ph(chalky, alkaline).
ideal_ph(silt, slightly_acidic).

% Organic Matter Content
organic_matter(loamy, high).
organic_matter(clay, moderate).
organic_matter(sandy, low).
organic_matter(peat, very_high).
organic_matter(saline, low).
organic_matter(chalky, moderate).
organic_matter(silt, moderate).

% Soil Moisture Levels
soil_moisture(loamy, moderate).
soil_moisture(clay, high).
soil_moisture(sandy, low).
soil_moisture(peat, very_high).
soil_moisture(saline, low).
soil_moisture(chalky, moderate).
soil_moisture(silt, high).

% Electrical Conductivity (EC) Levels
electrical_conductivity(loamy, moderate).
electrical_conductivity(clay, high).
electrical_conductivity(sandy, low).
electrical_conductivity(peat, very_high).
electrical_conductivity(saline, extreme).
electrical_conductivity(chalky, moderate).
electrical_conductivity(silt, moderate).

% Soil Types and their Ideal Conditions (Additional Details)
ideal_soil_condition(loamy, "Well-drained, high in nutrients").
ideal_soil_condition(clay, "Heavy soil, holds nutrients but drains slowly").
ideal_soil_condition(sandy, "Well-drained but nutrient-poor").
ideal_soil_condition(peat, "Acidic, high organic matter").
ideal_soil_condition(saline, "High in salts, poor for most crops").
ideal_soil_condition(chalky, "Alkaline soil, good for lime-loving plants").
ideal_soil_condition(silt, "Smooth texture, holds nutrients but can compact easily").

% Soil Type to Organic Matter Relationship
organic_matter_soil_type(SoilType, OrganicMatterLevel) :-
    organic_matter(SoilType, OrganicMatterLevel).
