:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(server(utils)).

% Route for fertilizer recommendations
:- http_handler(root(recommend_fertilizer), recommend_fertilizer_request, []).

% Main handler for fertilizer recommendations
recommend_fertilizer_request(Request) :-
    % Extract JSON data from the request body
    http_read_json(Request, Data),
    
    % Extract the parameters from the incoming request
    get_dict(cropType, Data, CropType),
    get_dict(growthStage, Data, GrowthStage),
    get_dict(yieldTarget, Data, YieldTarget),
    get_dict(fertilizerHistory, Data, FertilizerHistory),
    get_dict(waterRequirements, Data, WaterRequirements),
    get_dict(temperature, Data, Temperature),
    get_dict(humidity, Data, Humidity),
    get_dict(rainfall, Data, Rainfall),
    get_dict(season, Data, Season),
    get_dict(location, Data, Location),
    get_dict(pHLevel, Data, PhLevel),
    get_dict(nitrogen, Data, Nitrogen),
    get_dict(phosphorous, Data, Phosphorous),
    get_dict(potassium, Data, Potassium),
    get_dict(soilType, Data, SoilType),
    get_dict(organicMatter, Data, OrganicMatter),
    get_dict(soilMoisture, Data, SoilMoisture),
    get_dict(electricalConductivity, Data, ElectricalConductivity),
    get_dict(preferedFertilizerType, Data, PreferredFertilizerType),
    get_dict(preferedApplicationMethod, Data, PreferredApplicationMethod),
    
    % Validate all input parameters
    (   validate_crop_type(CropType),
        validate_growth_stage(GrowthStage),
        validate_yield_target(YieldTarget),
        validate_soil_type(SoilType),
        validate_fertilizer_history(FertilizerHistory),
        validate_temperature(Temperature),
        validate_water_requirements(WaterRequirements),
        validate_soil_moisture(SoilMoisture),
        validate_ph_level(PhLevel),
        validate_nitrogen(Nitrogen),
        validate_phosphorous(Phosphorous),
        validate_potassium(Potassium),
        validate_organic_matter(OrganicMatter),
        validate_electrical_conductivity(ElectricalConductivity),
        validate_preferred_fertilizer_type(PreferredFertilizerType),
        validate_preferred_application_method(PreferredApplicationMethod),
        
        % If all parameters are valid, generate the recommendation
        recommend_fertilizer(CropType, GrowthStage, YieldTarget, FertilizerHistory, WaterRequirements, Temperature, Humidity, Rainfall, Season, Location, PhLevel, Nitrogen, Phosphorous, Potassium, SoilType, OrganicMatter, SoilMoisture, ElectricalConductivity, PreferredFertilizerType, PreferredApplicationMethod, Recommendation),
        
        % Respond with the recommendation
        reply_json(json([recommendation=Recommendation]))
    ;
        % If validation fails, return an error
        reply_json(json([error='Invalid input parameters']), [status(400)])
    ).

% Define validation rules for pH level, nitrogen, phosphorous, potassium, organic matter, and electrical conductivity

validate_ph_level(PhLevel) :-
    member(PhLevel, ["acidic", "neutral", "alkaline", "slightlyAcidic", "slightlyAlkaline"]).

validate_nitrogen(Nitrogen) :-
    member(Nitrogen, ["low", "moderate", "high", "veryHigh"]).

validate_phosphorous(Phosphorous) :-
    member(Phosphorous, ["low", "moderate", "high", "veryHigh"]).

validate_potassium(Potassium) :-
    member(Potassium, ["low", "moderate", "high", "veryHigh"]).

validate_organic_matter(OrganicMatter) :-
    member(OrganicMatter, ["low", "moderate", "high", "veryHigh"]).

validate_electrical_conductivity(ElectricalConductivity) :-
    member(ElectricalConductivity, ["low", "moderate", "high", "veryHigh", "extreme"]).

validate_preferred_fertilizer_type(PreferredFertilizerType) :-
    member(PreferredFertilizerType, ["NPK", "compost", "organic", "slow-release"]).

validate_preferred_application_method(PreferredApplicationMethod) :-
    member(PreferredApplicationMethod, ["broadcasting", "fertigation", "side-dressing"]).
