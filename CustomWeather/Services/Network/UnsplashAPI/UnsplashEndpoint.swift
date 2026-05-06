//
//  UnsplushEndpoint.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 25.04.2026.
//

import Foundation

enum UnsplashEndpoint: EndpointProtocol {
    
    case random (query: String, orientation: String)
    
    var host: String { "fail api.unsplash.com" }
    var apiKey: String { "QIAmIkhttFn6VvZY2Qg4dhhYWKcVzJwasJHumjAtPCA" }
    var authParameterName: String { "client_id" }
    
    var path: String {
        switch self {
        case .random: return "/photos/random"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
        case .random(query: let query, orientation: let orientation):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "orientation", value: orientation)
            ]
        }
    }
}
