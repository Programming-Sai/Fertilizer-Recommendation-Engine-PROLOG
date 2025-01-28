import re

def remove_impracticals(input_file, output_file, impracticals):
    """
    Removes lines matching the impractical patterns from the input file and writes the remaining lines to the output file.

    Args:
        input_file (str): Path to the input file.
        output_file (str): Path to the output file.
        impracticals (list): List of regex patterns for impractical facts.
    """
    with open(input_file, 'r') as f:
        lines = f.readlines()  # Read all lines

    # Loop through each pattern and remove matching lines
    for pattern in impracticals:
        lines = [line for line in lines if not re.search(pattern, line)]

    # Write the remaining lines to the output file
    with open(output_file, 'w') as f:
        f.writelines(lines)



def print_impracticals(input_file, impracticals):
    for i in impracticals:
        with open(input_file, 'r') as f:
            m = f.readlines()
            # Use a proper regular expression to match 'crop(*, *, *, low, high).'
            # Replace '*' with '.*' to match any characters in place of '*'
            # print(m)
            for line in m:
                if re.search(i, line):  
                    print(line)  # If the pattern matches, print the line
                else:
                    print('---') 


def actual_cleanse(input_files, impractical_patterns_list):
    for input_file, impractical_patterns in zip(input_files, impractical_patterns_list):
        remove_impracticals(input_file, input_file, impractical_patterns)


# Example usage
if __name__ == "__main__":
    input_files = [
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/crop_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/environmental_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/cereal_soil_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/vegetable_soil_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/legume_soil_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/oilseed_soil_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/fruit_soil_facts.pl', 
                    '/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/facts/soil_facts/tuber_soil_facts.pl', 
                  ]
    
    impractical_patterns_list = [
        [
            r'^crop\([^,]*, [^,]*, [^,]*, low, high\)\.',    # Low fertilizer + High water
            r'^crop\([^,]*, [^,]*, high, low, [^)]*\)\.',    # High yield + Low fertilizer
            r'^crop\([^,]*, [^,]*, [^,]*, high, low\)\.',    # High fertilizer + Low water
            r'^crop\([^,]*, [^,]*, high, [^,]*, low\)\.',    # High yield + Low water
            r'^crop\([^,]*, early, [^,]*, high, [^)]*\)\.'   # Early growth stage + High fertilizer
        ],
        [
            r'^environment\([^,]*, low, high, [^,]*, [^,]*, [^)]*\)\.',  # Low temperature + High humidity
            r'^environment\([^,]*, [^,]*, low, high, [^,]*, [^)]*\)\.',  # Low humidity + High rainfall
            r'^environment\([^,]*, [^,]*, high, low, [^,]*, [^)]*\)\.',  # High humidity + Low rainfall
            r'^environment\([^,]*, low, [^,]*, [^,]*, summer, [^)]*\)\.',  # Low temperature in summer
        ],
        [
            r'soil_cereal\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_cereal\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_cereal\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_cereal\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_cereal\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_cereal\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_cereal\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ],
        [
            r'soil_vegetable\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_vegetable\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_vegetable\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_vegetable\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_vegetable\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_vegetable\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_vegetable\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ],
        [
            r'soil_legume\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_legume\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_legume\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_legume\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_legume\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_legume\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_legume\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ],
        [
            r'soil_oilseed\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_oilseed\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_oilseed\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_oilseed\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_oilseed\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_oilseed\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_oilseed\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ],
        [
            r'soil_fruit\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_fruit\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_fruit\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_fruit\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_fruit\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_fruit\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_fruit\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ],
        [
            r'soil_tuber\([^,]*, [^,]*, [^,]*, low, low, low, low, [^,]*, [^)]*\)\.',  # Insufficient nutrients
            r'soil_tuber\([^,]*, [^,]*, [^,]*, high|veryHigh, [^,]*, [^,]*, [^,]*, low, [^)]*\)\.',  # Excessive nitrogen + low moisture
            r'soil_tuber\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, low|moderate, [^,]*, high|veryHigh|extreme\)\.',  # Poor organic matter + high conductivity
            r'soil_tuber\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, high|veryHigh, low\)\.',  # High moisture + low conductivity
            r'soil_tuber\([^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, extreme\)\.',  # Unknown conductivity
            r'soil_tuber\([^,]*, clay, acidic|slightlyAcidic, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.',  # Low pH in clay soil
            r'soil_tuber\([^,]*, sandy, alkaline|slightlyAlkaline, [^,]*, [^,]*, [^,]*, [^,]*, [^,]*, [^)]*\)\.'  # High pH in sandy soil
        ]
    ]
    # actual_cleanse(input_files, impractical_patterns_list)
    


    # print_impracticals(input_file, impractical_patterns)


