//
//  Colors.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 20.03.2026.
//

import UIKit

enum Theme {
    
    // MARK: - Fonts
    
    enum Fonts {
        static let time = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let temperature = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let description = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        static let feelsLikeLabelFont = UIFont.systemFont(ofSize: 22, weight: .regular)
        
        static let cityTitle = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        //MARK: - MainScreenDaysForecastViewCell
        
        static let fontForTemperature = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    // MARK: - Colors

    enum Colors {
        static let mainText = UIColor.white
        static let secondaryText = UIColor.white.withAlphaComponent(0.7)
        
        static let sunnyTint = UIColor.systemYellow
        static let rainyTint = UIColor.systemBlue
        static let cloudyTint = UIColor.systemGray
    }
}
