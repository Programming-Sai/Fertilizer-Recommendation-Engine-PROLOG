from itertools import product


crop_conditions ={
          "cropType": [
            "cereal",
            "vegetable",
            "legume",
            "fruit",
            "oilseed",
            "tuber"
          ],
          "growthStage": [
            "seedling",
            "vegetative",
            "flowering",
            "fruiting",
            "harvest"
          ],
          "yieldTarget": [
            "low",
            "moderate",
            "high",
            "slightlyHigh",
            "veryHigh"
          ],
          "fertilizerHistory": ["none", "low", "moderate", "high"],
          "waterRequirements": [
            "low",
            "moderate",
            "high",
            "veryHigh",
            "variable"
          ],
}

environment_conditions = {
          "cropType": [
            "cereal",
            "vegetable",
            "legume",
            "fruit",
            "oilseed",
            "tuber"
          ],
          "temperature": ["cold", "cool", "moderate", "hot", "veryHot"],
          "humidity": ["low", "moderate", "high", "veryHigh", "extreme"],
          "rainfall": ["low", "moderate", "high", "veryHigh", "variable"],
          "season": ["spring", "summer", "autumn", "winter", "wet", "dry"],
          "location": [
            "tropical",
            "temperate",
            "arid",
            "mountainous",
            "coastal"
          ],
}


soil_conditions = {
          "cropType": [
            "cereal",
            "vegetable",
            "legume",
            "fruit",
            "oilseed",
            "tuber"
          ],
          "pHLevel": [
            "acidic",
            "neutral",
            "alkaline",
            "slightlyAcidic",
            "slightlyAlkaline"
          ],
          "nitrogen": ["low", "moderate", "high", "veryHigh"],
          "phosphorous": ["low", "moderate", "high", "veryHigh"],
          "potassium": ["low", "moderate", "high", "veryHigh"],
          "soilType": [
            "loamy",
            "clay",
            "sandy",
            "peat",
            "saline",
            "chalky",
            "silt"
          ],
          "organicMatter": ["low", "moderate", "high", "veryHigh"],
          "soilMoisture": ["low", "moderate", "high", "veryHigh"],
          "electricalConductivity": [
            "low",
            "moderate",
            "high",
            "veryHigh",
            "extreme"
          ],
}

def generate_facts(conditions, based_on, type, cat):
    # Ensure keys are ordered according to 'based_on'
    keys = based_on
    values = [conditions[key] for key in keys]

    # Generate all combinations
    combinations = list(product(*values))

    # Create facts as strings
    facts = [
        f"{type}({', '.join(combination)})." for combination in combinations if combination[0] == cat
    ]

    return facts


# Define the order of keys to base combinations on



# crop_based_on = ["cropType", "growthStage", "yieldTarget", "fertilizerHistory", "waterRequirements"]
# # Generate facts
# facts = generate_facts(crop_conditions, crop_based_on, 'crop')

# # Print the generated facts
# for fact in facts:
#     print(fact)


# environment_based_on = ["cropType", "temperature", "humidity", "rainfall", "season", "location"]
# # Generate facts
# facts = generate_facts(environment_conditions, environment_based_on, 'environment')

# # Print the generated facts
# for fact in facts:
#     print(fact)


soil_based_on = ["cropType", "soilType", "pHLevel", "nitrogen", "phosphorous", "potassium", "organicMatter", "soilMoisture", "electricalConductivity"]
# Generate facts

for cat in ["cereal", "vegetable","legume","fruit", "oilseed", "tuber"]:
    facts = generate_facts(soil_conditions, soil_based_on, 'soil', cat)



    with open(f'/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/{cat}_soil_facts.pl', 'w') as f:
        f.write(f"\n\n% This file contains soil-related facts for {cat.capitalize()} crops. \n% It includes various combinations of soil conditions such as \n\n%\t- soil type\n%\t- pH level\n%\t- nitrogen\n%\t- phosphorous\n%\t- potassium\n%\t- organic matter\n%\t- soil moisture\n%\t- electrical conductivity\n\n% All suited for {cat.capitalize()} growth.\n\n\n")

    # Now append the facts using append mode
    with open(f'/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/{cat}_soil_facts.pl', 'a') as f:
        f.writelines(fact + '\n' for fact in facts)