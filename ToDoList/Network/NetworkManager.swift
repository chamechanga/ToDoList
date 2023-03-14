//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<WeatherAPI> { get }
    
    func getForecast(latitude: Float, longitude: Float, hourly: String, currentWeather: Bool, completion: @escaping (Forecast?, Error?) -> ())
}

class NetworkManager: Networkable {
    let provider = MoyaProvider<WeatherAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getForecast(
        latitude: Float,
        longitude: Float,
        hourly: String,
        currentWeather: Bool,
        completion: @escaping (Forecast?, Error?) -> ())
    {
        provider.request(.forecast(latitude: latitude, longitude: longitude, hourly: hourly, currentWeather: currentWeather)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                
                do {
                    let forecast = try decoder.decode(Forecast.self, from: response.data)
                    completion(forecast, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
