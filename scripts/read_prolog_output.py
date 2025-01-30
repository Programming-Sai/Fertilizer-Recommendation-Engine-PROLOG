from pyswip import Prolog
import json
import ast
import re

def pread(query=None):
    recommender = "/Users/mac/Desktop/Fertilizer-Recommendation-Engine-PROLOG/src/rules/recommendation_rules.pl"
    prolog = Prolog()
    prolog.consult(recommender)
    result={}
    query = query or "recommend_fertilizer(cereal, vegetative, moderate, low, moderate, cool, moderate, high, high, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation)."
    r = list(list(prolog.query(query)))[0]['Recommendation'].split(',(:')

    lines=[re.sub(', ', ': ', i.replace('b', '').replace('{}', '').replace('(', '').replace(')', ''), count=1) for i in r]
    lines.remove('')


    result['fertilizerType'] = lines[0].split(': ')[1].replace("'", '').replace(', ', '')
    result['NPK']={
        'ratio': lines[2].split(': ')[1].replace("'", '').replace(', ', ''),
        'values': {
            'N': lines[4].split(': ')[1].replace("'", '').replace(', ', ''),
            'P': lines[5].split(", :")[0].split(': ')[1].replace("'", ''),
            'K': lines[5].split(", :")[1].split(': ')[0].split(", ")[1].replace("'", ''),
        },
        'units': lines[5].split(", :")[2].split(", ")[1],
    }
    result['applicationMode']=lines[6].split(': ')[1].replace("'", '').replace(', ', '')
    result['frequency']=lines[7].split(":'")[0].split(': ')[1].replace("'", '').replace(', ', '')
    result['reasoning']=ast.literal_eval(lines[7].split(":'")[1].replace('reasoning\', ', ''))

    return json.dumps(result, indent=4), result
   
# Run the function
# print(pread()[0])
# print(pread("recommend_fertilizer(tuber, vegetative, moderate, low, moderate, cool, moderate, high, moderate, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation).")[0])
