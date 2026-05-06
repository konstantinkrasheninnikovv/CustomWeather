//
//  Endpoint.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 16.03.2026.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var host: String { get }
    var apiKey: String { get }
    var authParameterName: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension EndpointProtocol {
    
    var scheme: String { "https" }
//    var host: String { "api.weatherapi.com" }
    
    func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        var items = queryItems
        items.append(URLQueryItem(name: authParameterName, value: apiKey))
        components.queryItems = items
        
        return components.url
    }
}
