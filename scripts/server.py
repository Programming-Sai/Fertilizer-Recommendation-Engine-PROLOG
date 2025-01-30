from flask import Flask, request, jsonify
from read_prolog_output import pread
from predicate_to_params import p2q


server = Flask(__name__)

@server.route('/recommend', methods=['GET'])
def recommend_fertilizer():
    crop_type = request.args.get('crop_type')
    growth_stage = request.args.get('growth_stage')
    yield_target = request.args.get('yield_target')
    fertilizer_history = request.args.get('fertilizer_history')
    water_requirement = request.args.get('water_requirement')
    soil_type = request.args.get('soil_type')
    ph_level = request.args.get('ph_level')
    nitrogen = request.args.get('nitrogen')
    phosphorous = request.args.get('phosphorous')
    potassium = request.args.get('potassium')
    organic_matter = request.args.get('organic_matter')
    soil_moisture = request.args.get('soil_moisture')
    electrical_conductivity = request.args.get('electrical_conductivity')
    temperature = request.args.get('temperature')
    humidity = request.args.get('humidity')
    rainfall = request.args.get('rainfall')
    season = request.args.get('season')
    location = request.args.get('location')

    # List of parameters to check
    required_params = [
        'crop_type', 'growth_stage', 'yield_target', 'fertilizer_history', 'water_requirement',
        'soil_type', 'ph_level', 'nitrogen', 'phosphorous', 'potassium', 'organic_matter',
        'soil_moisture', 'electrical_conductivity', 'temperature', 'humidity', 'rainfall',
        'season', 'location'
    ]

    # Check for missing parameters
    missing_params = [param for param in required_params if not request.args.get(param)]

    if missing_params:
        return jsonify({'error': f'Missing required parameters: {", ".join(missing_params)}'}), 400


    prolog_query = f"""
    recommend_fertilizer('{crop_type}', '{growth_stage}', '{yield_target}', '{fertilizer_history}', '{water_requirement}', 
    '{soil_type}', '{ph_level}', '{nitrogen}', '{phosphorous}', '{potassium}', '{organic_matter}', '{soil_moisture}', 
    '{electrical_conductivity}', '{temperature}', '{humidity}', '{rainfall}', '{season}', '{location}', Recommendation).
    """

    recommendation = pread(query=prolog_query)[1]
    # recommendation['url']=p2q(prolog_query, http_prefix="http://127.0.0.1:5000/recommend?")

    # Return the recommendation as JSON
    return jsonify({'recommendation': recommendation})



if __name__ == '__main__':
    server.run(debug=True)