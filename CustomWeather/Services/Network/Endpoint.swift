//
//  Endpoint.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 16.03.2026.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    
    var scheme: String { "https" }
    var host: String { "api.weatherapi.com" }
    var apiKey: String { "1e2053de62d349f893e51432251905" }
    
    func makeURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        var items = queryItems
        items.append(URLQueryItem(name: "key", value: apiKey))
        components.queryItems = items
        
        return components.url
    }
}
