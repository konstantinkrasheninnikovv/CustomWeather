//
//  UnsplashResponse.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 26.04.2026.
//

import Foundation

struct UnsplashResponse: Decodable {
    let urls: URLs
}

struct URLs: Decodable {
    let regular: String
}
