//
//  WeatherDTO.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 15.03.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let current: CurrentWeather
    let forecast: ForecastWeather?
    let location: Location
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let feelslikeC: Double
    let condition: Condition
    let pressure: Double
    let windSpeed: Double
    let humidity: Int
    let time: String
    let uv: Double
    let airQuality: AirQuality?
    let visibilityKM: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case condition
        case pressure = "pressure_mb"
        case windSpeed = "wind_kph"
        case humidity
        case time = "last_updated"
        case uv
        case airQuality = "air_quality"
        case visibilityKM = "vis_km"
    }
}

struct ForecastWeather: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let hour: [Hour]
    let day: Day
    
    enum CodingKeys: String, CodingKey {
        case date
        case hour
        case day
    }
}

struct Hour: Decodable {
    let time: String
    let tempC: Double
    let condition: Condition
    let rainChance: Int
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
        case rainChance = "chance_of_rain"
    }
}

struct Location: Decodable {
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
    }
}

struct Condition: Decodable {
    let conditionDescription: String
    let weatherCode: Int
    
    enum CodingKeys: String, CodingKey {
        case conditionDescription = "text"
        case weatherCode = "code"
    }
}

struct AirQuality: Decodable {
    let pm25: Double
    
    enum CodingKeys: String, CodingKey {
        case pm25 = "pm2_5"
    }
}

struct Day: Decodable {
    let averageTemparatureC: Double
    let minTempC: Double
    let maxTempC: Double
    let condition: Condition
    let rainChance: Int
    
    enum CodingKeys: String, CodingKey {
        case averageTemparatureC = "avgtemp_c"
        case minTempC = "mintemp_c"
        case maxTempC = "maxtemp_c"
        case condition
        case rainChance = "daily_chance_of_rain"
    }
}
