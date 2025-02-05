from pyswip import Prolog
import json
import ast
import re
import os


prolog = Prolog()
lookup_words = [
    'broadcasting', 'Tuber', 'broadcast', 'balanced', "boron", "biological", "buffering", 
    "bulk", "bacterium", "boron deficiency", "base fertilizer", 
    "bedding", "biodegradable", "blended fertilizer", "biosolid", 
    "beneficial microorganisms", "bacterial inoculant", "buffering capacity", "budding"
] 

lookup_words += [i.capitalize() for i in lookup_words]


def pread(query=None):
    recommender = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'src', 'rules', 'recommendation_rules.pl')
    prolog.consult(recommender)
    result={}
    query = query or "recommend_fertilizer(cereal, vegetative, moderate, low, moderate, cool, moderate, high, high, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, _, Recommendation)."
    raw_result = list(prolog.query(query))
 
    if raw_result:
        r = list(raw_result)[0]['Recommendation'].split(',(:')
        lines=[re.sub(', ', ': ', (i.replace("b", '')).replace('{}', '').replace('(', '').replace(')', ''), count=1) for i in r]
        lines.remove('')
        


        result['fertilizerType'] = lines[0].split(': ')[1].replace("'", '').replace(', ', '')
        result['NPK']={
            'ratio': lines[2].split(': ')[1].replace("'", '').replace(', ', ''),
            'values': {
                'N': lines[4].split(': ')[1].replace("'", '').replace(', ', ''),
                'P': lines[5].split(", :")[0].split(': ')[1].replace("'", ''),
                'K': lines[5].split(", :")[1].split(': ')[0].split(", ")[1].replace("'", ''),
            },
            'units': lines[5].split(", :")[2].split(", ")[1].replace("'", ''),
        }
        result['applicationMode']=get_missing_b(lookup_words, lines[6].split(': ')[1].replace("'", '').replace(', ', ''))
        result['frequency']=lines[7].split(":'")[0].split(': ')[1].replace("'", '').replace(', ', '')
        result['reasoning']=get_missing_b(lookup_words, ast.literal_eval(lines[7].split(":'")[1].replace('reasoning\', ', '')))

        # return raw_result
        return json.dumps(result, indent=4), result, raw_result
    return {}, [], raw_result


def get_missing_b(lookup_words, word):
    if isinstance(word, str):
        for lookup_word in lookup_words:
            if word.lower() == lookup_word.replace("b", "").lower():
                return lookup_word  # Return the corrected word
        return word  # If no match is found, return the original word

    elif isinstance(word, list):
        corrected_list = []
        for w in word:
            words = w.split()  # Split the string into words
            corrected_words = []
            for w_word in words:
                corrected_word = w_word  # Default to original
                for lookup_word in lookup_words:
                    if lookup_word.replace("b", "").lower() in w_word.lower():
                        corrected_word = lookup_word  # Replace if match found
                        break  # Stop checking after the first match
                corrected_words.append(corrected_word)
            corrected_list.append(" ".join(corrected_words))  # Rejoin the words into a corrected string
        return corrected_list





# Run the function
# print(pread()[0])
# print(pread("recommend_fertilizer(tuber, vegetative, moderate, low, moderate, cool, moderate, high, moderate, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation).")[0])

# x="recommend_fertilizer(vegetable, vegetative, moderate, low, veryHigh, sandy, slightlyAlkaline, moderate, high, moderate, high, moderate, moderate, hot, high, moderate, autumn, arid, _, Recommendation)."


# print(get_missing_b(lookup_words, "roadcast"))

# print(pread(x)[0])