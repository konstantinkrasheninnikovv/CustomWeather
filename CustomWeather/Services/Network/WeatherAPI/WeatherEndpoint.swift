//
//  WeatherEndpoint.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 16.03.2026.
//

import Foundation

enum WeatherEndpoint: EndpointProtocol {
    case current(city: String, aqi: String)
    case forecast(city: String, days: Int)

    var host: String { "api.weatherapi.com" }
    var authParameterName: String { "key" }
    var apiKey: String { "1e2053de62d349f893e51432251905" }

    var path: String {
        switch self {
        case .current: return "/v1/current.json"
        case .forecast: return "/v1/forecast.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
        case .current(let city, let aqi):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "aqi", value: "\(aqi)")
            ]
            
        case .forecast(let city, let days):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: "\(days)")
            ]
        }
    }
}
