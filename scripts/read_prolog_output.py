from pyswip import Prolog
import json
import ast
import re
import os

lookup_words = ['broadcasting', 'Tuber']

def pread(query=None):
    recommender = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'src', 'rules', 'recommendation_rules.pl')
    prolog = Prolog()
    prolog.consult(recommender)
    result={}
    query = query or "recommend_fertilizer(cereal, vegetative, moderate, low, moderate, cool, moderate, high, high, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation)."
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
    return {}, [], []


def get_missing_b(lookup_words, word):
    if isinstance(word, str):
        return [lookup_word if word.lower() == lookup_word.replace("b", '').lower() else word for lookup_word in lookup_words][0]
    elif isinstance(word, list):
        for lookup_word in lookup_words:
            for idx, w in enumerate(word):
                for wo in w.split(" "):
                    d = lookup_word
                    if wo.lower() == lookup_word.replace("b", '').lower():
                        word[idx] = w.replace(wo, d)
        return word







# Run the function
# print(pread()[0])
# print(pread("recommend_fertilizer(tuber, vegetative, moderate, low, moderate, cool, moderate, high, moderate, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation).")[0])

x="recommend_fertilizer(vegetable, vegetative, moderate, low, moderate, loamy, neutral, high, high, moderate, high, moderate, moderate, cool, high, moderate, spring, arid, Recommendation)."



print(pread(x)[0])