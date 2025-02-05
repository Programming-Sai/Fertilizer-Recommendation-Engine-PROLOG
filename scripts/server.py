from flask import Flask, request, jsonify, render_template, send_from_directory
from read_prolog_output import pread, prolog
from flask_cors import CORS
import webbrowser
import atexit


server = Flask(__name__)

def cleanup():
    try:
        print("Stopping PROLOG engine...")
        list(prolog.query("halt."))  
        print("PROLOG engine stopped.")
    except Exception as e:
        print(f"Error stopping Prolog: {e}")

atexit.register(cleanup)  # Register cleanup function




CORS(server)

@server.route('/')
def index():
    return render_template('index.html')  

@server.route('/recommend', methods=['GET'])
def recommend_fertilizer():
    crop_type = request.args.get('cropType')
    growth_stage = request.args.get('growthStage')
    yield_target = request.args.get('yieldTarget')
    fertilizer_history = request.args.get('fertilizerHistory')
    water_requirement = request.args.get('waterRequirements')
    soil_type = request.args.get('soilType')
    ph_level = request.args.get('pHLevel')
    nitrogen = request.args.get('nitrogen')
    phosphorous = request.args.get('phosphorous')
    potassium = request.args.get('potassium')
    organic_matter = request.args.get('organicMatter')
    soil_moisture = request.args.get('soilMoisture')
    electrical_conductivity = request.args.get('electricalConductivity')
    temperature = request.args.get('temperature')
    humidity = request.args.get('humidity')
    rainfall = request.args.get('rainfall')
    season = request.args.get('season')
    location = request.args.get('location')



    required_params = [
        'cropType', 'growthStage', 'yieldTarget', 'fertilizerHistory', 'waterRequirements',
        'soilType', 'pHLevel', 'nitrogen', 'phosphorous', 'potassium', 'organicMatter',
        'soilMoisture', 'electricalConductivity', 'temperature', 'humidity', 'rainfall',
        'season', 'location'
    ]


    missing_params = [param for param in required_params if not request.args.get(param)]

    if missing_params:
        return jsonify({'error': f'Missing required parameters: {", ".join(missing_params)}'}), 400


    prolog_query = f"recommend_fertilizer('{crop_type}', '{growth_stage}', '{yield_target}', '{fertilizer_history}', '{water_requirement}', '{soil_type}', '{ph_level}', '{nitrogen}', '{phosphorous}', '{potassium}', '{organic_matter}', '{soil_moisture}', '{electrical_conductivity}', '{temperature}', '{humidity}', '{rainfall}', '{season}', '{location}', _, Recommendation)." 
    
    recommendation = pread(query=prolog_query)[1]

    return jsonify({'recommendation': recommendation})




if __name__ == '__main__':
    try:
        print("Starting server...")
        # Print server access URL
        print(f"Server is accessible at: http://localhost:5000/")

        # Open the server URL in the default web browser
        webbrowser.open("http://localhost:5000/")

        # Run the server
        server.run(host="0.0.0.0", port=5000, debug=False)   
    except Exception as e:
        print(f"Failed to start the server. Error: {e}")