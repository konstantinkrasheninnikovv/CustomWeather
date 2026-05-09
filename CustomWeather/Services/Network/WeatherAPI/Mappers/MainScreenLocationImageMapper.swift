//
//  MainScreenImageMapper.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 27.04.2026.
//

import UIKit

struct MainScreenLocationImageMapper {
    static func mapDataImage(_ model: MainScreenBackgroundModel) -> MainScreenBackgroundViewModel {
        
        let imageViewModel =  BaseImageViewModel(
            imageName: nil,
            image: model.image,
            placeholder: UIImage(named: "default_weather_bg")
        )
        
       return MainScreenBackgroundViewModel(imageViewModel: imageViewModel, backgroundColor: model.averageColor)
    }
}
