import urllib.parse

base_url = "http://localhost:8080/recommendation?"
query_params = "cropType=tuber&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=moderate&season=spring&location=temperate&pHLevel=neutral&nitrogen=moderate&phosphorous=moderate&potassium=moderate&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate"

# Encode the query parameters only
encoded_query_params = '&'.join([f"{key}={urllib.parse.quote(value)}" for key, value in (param.split('=') for param in query_params.split('&'))])

encoded_url = base_url + encoded_query_params
print(encoded_url)
