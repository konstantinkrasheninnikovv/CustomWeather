//
//  ImageLoader.swift
//  CustomWeather
//
//  Created by Konsntantin Krasheninnikov on 27.04.2026.
//

import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    private init() {}
    
    //MARK: - Public functions
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let urlString = url.absoluteString as NSString
        
        if let cachedImage = cache.object(forKey: urlString) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            self?.cache.setObject(image, forKey: urlString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
