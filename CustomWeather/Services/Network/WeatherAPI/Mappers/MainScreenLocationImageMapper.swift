//
//  MainScreenImageMapper.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 27.04.2026.
//

import UIKit

struct MainScreenLocationImageMapper {
    static func mapDataImage(_ data: URLs) -> BaseImageViewModel {
        let url = URL(string: data.regular)
        
        return BaseImageViewModel(
            imageName: nil,
            imageURL: url,
            placeholder: UIImage(named: "default_weather_bg")
        )
    }
}
