//
//  APIService.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import Moya

enum WeatherAPI {
    case forecast(latitude: Float, longitude: Float, hourly: String, currentWeather: Bool)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.open-meteo.com/v1/")!
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "forecast"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .forecast(let latitude, let longitude, let hourly, let currentWeather):
            return .requestParameters(parameters: ["latitude": latitude,
                                                   "longitude": longitude,
                                                   "hourly": hourly,
                                                   "current_weather": currentWeather],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json; charset=UTF-8"]
    }
}
