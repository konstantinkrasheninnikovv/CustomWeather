//
//  NetworkManager.swift
//  CustomWeather
//
//  Created by Konsntantin Krasheninnikov on 17.03.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case noData
}

final class NetworkManager {
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        
        guard let url = endpoint.makeURL() else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.serverError(statusCode: 0)
                }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode(T.self, from: data)
                } catch {
                    print("Ошибка декодирования: \(error)")
                    throw NetworkError.decodingError
                }
    }
}
