//
//  WeatherDTO.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 15.03.2026.
//

import Foundation

struct WeatherResponse: Decodable {
    let current: CurrentWeather
    let location: Location
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let feelslikeC: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
    }
}

struct Location: Decodable {
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        
    }
}
