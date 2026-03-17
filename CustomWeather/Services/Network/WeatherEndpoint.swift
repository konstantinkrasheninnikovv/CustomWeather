//
//  WeatherEndpoint.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 16.03.2026.
//

import Foundation

enum WeatherEndpoint: Endpoint {
    case current(city: String)
    case forecast(city: String, days: Int)

    var path: String {
        switch self {
        case .current: return "/v1/current.json?"
        case .forecast: return "/v1/forecast.json?"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
        case .current(let city):
            return [URLQueryItem(name: "q", value: city)]
        case .forecast(let city, let days):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: "\(days)")
            ]
        }
    }
}
