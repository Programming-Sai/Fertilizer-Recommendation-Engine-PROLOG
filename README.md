# **Fertilizer Recommendation Engine - PROLOG**

This project provides a Prolog-based backend for recommending fertilizers based on crop, soil and environmental inputs. It integrates with a Flask server to deliver recommendations via a RESTful API. The system utilizes Prolog for inference and supports querying for fertilizer recommendations via a `GET` request.

## Table of Contents

- [Installation](#installation)
- [Running the Server with Docker](#running-the-server-with-docker)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Files Explanation](#files-explanation)
  - [Prolog Facts Files](#prolog-facts-files)
  - [Flask Application](#flask-application)
- [API Usage](#api-usage)

---

## Installation

To get the system up and running, follow these steps:

1. **Clone the repository**:

   Clone the repository to your local machine:

   ```bash
   git clone https://github.com/Programming-Sai/Fertilizer-Recommendation-Engine-PROLOG.git
   cd Fertilizer-Recommendation-Engine-PROLOG
   ```

2. **Install Swi-Prolog**  
   This project requires Swi-Prolog for running Prolog queries.

   - Download and install Swi-Prolog from [Swi-Prolog's official site](https://www.swi-prolog.org/Download.html).

3. **Setup Python Virtual Environment**  
   Make sure you have Python 3.x installed. Set up a virtual environment for this project:

   ```bash
   python -m venv .prolog-backend
   ```

4. **Activate Virtual Environment**  
   Activate the virtual environment:

   - On Windows:
     ```bash
     .\.prolog-backend\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source .prolog-backend/bin/activate
     ```

5. **Install Required Python Packages**  
   Install necessary Python packages using pip:

   ```bash
   pip install -r requirements.txt
   ```

6. **Start the Flask Server**  
   Run the Flask server with the following command:

   ```bash
   python /scripts/server.py
   ```

   The server should now be running at `http://127.0.0.1:5000/`.

---

Got it! Here's a new section focused solely on running the application using the main `server` repo without the submodule:

---

## Running the Server with Docker

To run the **Fertilizer Recommendation Engine - PROLOG** using Docker, follow the steps below to build and launch the container.

### 1. Build the Docker Image

Ensure you're in the main `server` repo directory where the `Dockerfile` is located. To build the Docker image, use the following command:

```bash
docker build -t prolog-server .
```

This will build the Docker image named `prolog-server` using the Dockerfile in the current directory.

### 2. Run the Docker Container

After building the image, you can start the container using this command:

```bash
docker run -d -p 5000:5000 prolog-server
```

This runs the container in **detached mode**, mapping port `5000` of the container to port `5000` on your local machine. The Flask server should now be accessible at `http://127.0.0.1:5000/`.

### 3. Verify the Server is Running

You can check if the server is running by visiting `http://127.0.0.1:5000/` in your browser. If the server is working correctly, you should see the Flask application running.

Alternatively, check the logs of the running container with:

```bash
docker logs <container-id>
```

To get the container ID, run:

```bash
docker ps
```

### 4. Stop the Docker Container

If you need to stop the server, you can use the following command:

```bash
docker stop <container-id>
```

To get the container ID, run:

```bash
docker ps
```

### 5. Clean Up (Optional)

To remove any unused containers, images, or volumes, you can run:

```bash
docker system prune
```

This will help you clean up any resources you no longer need.

---

## Project Structure

Here’s a brief overview of the project structure:

```
Fertilizer-Recommendation-Engine-PROLOG/
├── src/
│   ├── facts/
│   │   ├── environmental_facts.pl
│   │   ├── crop_facts.pl
│   │   └── soil_facts/
│   |          ├── cereal_soil_facts.pl
│   |          ├── vegetable_soil_facts.pl
│   |          ├── oilseed_soil_facts.pl
│   |          ├── legume_soil_facts.pl
│   |          ├── fruit_soil_facts.pl
│   |          └── tuber_soil_facts.pl
│   └──  rules/
│           └── recommendation_rules.pl
├── scripts/
│   ├── delete_facts.py
│   ├── fact_generation.py
│   ├── predicate_to_params.py
│   └── read_prolog_output.py
│   └── server.py
|   └── static/
│   |   └── favicon.ico
│   └── templates/
│           └── index.html
├── data/
│   └── knowledge_base_skeleton.json
├── .gitignore
├── requirements.txt
├── Dockerfile
└── README.md
```

---

## How It Works

The **Fertilizer Recommendation System** uses Prolog for inference based on a set of facts and rules. The system is exposed through a Flask API, which receives crop and environmental parameters and returns a fertilizer recommendation.

- **Prolog Backend**: Prolog rules and facts define how fertilizers are recommended based on crop type, soil type, and other environmental factors.
- **Flask API**: The Flask server provides an endpoint (`/recommend`) to accept GET requests with query parameters. These parameters are sent to the Prolog engine, and a recommendation is returned.

---

## Files Explanation

### Prolog Facts Files

The **Prolog Facts Files** are essential for the system to function. They contain data about crops, soils, and fertilizers, which are used by the Prolog rules to generate recommendations. Below is a summary of each file:

1. **crop_facts.pl**  
   This file contains information about different crops, their growth stages, and their nutritional requirements. It also includes relevant data about environmental conditions suitable for each crop type.

2. **soil_facts**  
   This folder holds data related to different soil types, their properties, and the impact on crop growth. It includes soil pH levels, moisture content, and other factors crucial for determining the appropriate fertilizer.

3. **environmental_rules.pl**  
   This file contains information about different crops and their corresponding environmental conditions. It includes data about suitable temperature, humidity, rainfall, season, and location for each crop type.

### Flask Application

- **app.py**  
  This is the main entry point for the application. It sets up the Flask server and defines the `/recommend` route that accepts parameters like crop type, growth stage, soil type, etc. The route processes the request, constructs a Prolog query, and returns the recommendation in JSON format.

  - **/recommend route**:  
    Accepts the following parameters:
    - `cropType`
    - `growthStage`
    - `yieldTarget`
    - `fertilizerHistory`
    - `waterRequirements`
    - `soilType`
    - `pHLevel`
    - `nitrogen`
    - `phosphorous`
    - `potassium`
    - `organicMatter`
    - `soilMoisture`
    - `electricalConductivity`
    - `temperature`
    - `humidity`
    - `rainfall`
    - `season`
    - `location`

  The API then returns a JSON object containing the fertilizer recommendation.

- **requirements.txt**  
  Lists all the necessary Python libraries, including Flask and any other dependencies required to run the application.

---

## API Usage

You can test the API by sending a `GET` request to the `/recommend` route with the required parameters.

**Example Request:**

```bash
curl "http://127.0.0.1:5000/recommend?cropType=tuber&growthStage=vegetative&yieldTarget=moderate&fertilizerHistory=low&waterRequirements=moderate&temperature=cool&humidity=moderate&rainfall=high&season=moderate&location=high&pHLevel=neutral&nitrogen=high&phosphorous=moderate&potassium=high&soilType=loamy&organicMatter=moderate&soilMoisture=moderate&electricalConductivity=moderate"
```

**Example Response:**

```json
{
  "recommendation": {
    "NPK": {
      "ratio": "20:10:20",
      "units": "'kg/ha'",
      "values": {
        "K": "20",
        "N": "20",
        "P": "10"
      }
    },
    "applicationMode": "top-dressing",
    "fertilizerType": "NPK",
    "frequency": "every 45 days",
    "reasoning": [
      "Tuer crops need high potassium for starch synthesis.",
      "Nitrogen supports vegetative growth and leaf area development.",
      "Moderate phosphorous aids in root expansion.",
      "Top-dressing provides nutrients as crops mature."
    ]
  }
}
```

### Notes:

- Ensure that all required parameters are passed in the query string; otherwise, the API will return an error.
- You can access the status of the backend at the root (`/`).

---

## Conclusion

This project provides a robust system for recommending fertilizers based on crop and environmental conditions. By leveraging Prolog’s powerful reasoning capabilities, it provides accurate and context-specific recommendations to optimize agricultural practices.
