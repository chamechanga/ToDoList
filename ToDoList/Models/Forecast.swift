//
//  Forecast.swift
//  ToDoList
//
//  Created by Indra on 3/14/23.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentWeather: CurrentWeather
    let hourlyUnits: HourlyUnits
    let hourly: Hourly

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let temperature, windspeed: Double
    let winddirection, weathercode: Int
    let time: String
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}

/**
 {
     "latitude": 14.625,
     "longitude": 121.0,
     "generationtime_ms": 0.29098987579345703,
     "utc_offset_seconds": 0,
     "timezone": "GMT",
     "timezone_abbreviation": "GMT",
     "elevation": 12.0,
     "current_weather": {
         "temperature": 31.7,
         "windspeed": 5.0,
         "winddirection": 360.0,
         "weathercode": 3,
         "time": "2023-03-14T09:00"
     },
     "hourly_units": {
         "time": "iso8601",
         "temperature_2m": "°C"
     },
     "hourly": {
         "time": [
             "2023-03-14T00:00",
             "2023-03-14T01:00",
             "2023-03-14T02:00",
             "2023-03-14T03:00",
             "2023-03-14T04:00",
             "2023-03-14T05:00",
             "2023-03-14T06:00"
         ],
         "temperature_2m": [
             25.0,
             27.1,
             29.4,
             31.4,
             32.8,
             33.8
         ]
     }
 }
 */
