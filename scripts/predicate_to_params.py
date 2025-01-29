import json

def p2q(predicate):
    return "http://localhost:8080/recommendation?"+"&".join([f"{i}={j}" for i, j in zip(["cropType", "growthStage","yieldTarget","fertilizerHistory","waterRequirements","temperature","humidity","rainfall","season","location", "pHLevel","nitrogen","phosphorous", "potassium", "soilType", "organicMatter", "soilMoisture", "electricalConductivity" ], predicate.replace("recommend_fertilizer(", "").replace(").", "").split(", ")[:18])])
    


def q2p(query):
    return "recommend_fertilizer(" + " ".join([param.split('=')[1] + "," for param in query.replace("http://localhost:8080/recommendation?", "").split("&")]) + " Recommendation)."

def p2j(predicate):
    return json.dumps({key: value for key, value in zip(["cropType", "growthStage", "yieldTarget", "fertilizerHistory", "waterRequirements","temperature", "humidity", "rainfall", "season", "location", "pHLevel", "nitrogen","phosphorous", "potassium", "soilType", "organicMatter", "soilMoisture", "electricalConductivity"], predicate.replace("recommend_fertilizer(", "").replace(").", "").split(", ")[:18])})



  



# print("\n\n", q2p("http://localhost:8080/recommendation?cropType=cereal&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=high&season=high&location=high&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate"), "\n\n")


# print("\n\n", p2q("recommend_fertilizer(cereal, vegetative, moderate, low, moderate, cool, moderate, high, high, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation).") , "\n\n")


# print("\n\n", p2j("recommend_fertilizer(cereal, vegetative, moderate, low, moderate, cool, moderate, high, high, high, neutral, moderate, moderate, moderate, loamy, moderate, moderate, moderate, Recommendation).") , "\n\n")


print("\n\n", p2j(q2p("http://localhost:8080/recommendation?cropType=cereal&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=high&season=high&location=high&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate")), "\n\n")
