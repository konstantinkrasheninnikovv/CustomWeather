//
//  WeatherTypeForImage.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.04.2026.
//

import UIKit

//MARK: - https://www.weatherapi.com/docs/weather_conditions.json

enum WeatherType: Int {
    
    case clear = 1000
    case partlyCloudy = 1003
    case cloudy = 1006
    case overcast = 1009
    
    case mist = 1030
    case fog = 1135
    case freezingFog = 1147
    
    case patchyLightDrizzle = 1150
    case lightDrizzle = 1153
    case freezingDrizzle = 1168
    case heavyFreezingDrizzle = 1171
    
    case patchyRainPossible = 1063
    case patchyLightRain = 1180
    case lightRain = 1183
    case moderateRainAtTimes = 1186
    case moderateRain = 1189
    case heavyRainAtTimes = 1192
    case heavyRain = 1195
    case lightFreezingRain = 1198
    case moderateOrHeavyFreezingRain = 1201
    
    case lightRainShower = 1240
    case moderateOrHeavyRainShower = 1243
    case torrentialRainShower = 1246
    
    case patchySnowPossible = 1066
    case blowingSnow = 1114
    case blizzard = 1117
    case patchyLightSnow = 1210
    case lightSnow = 1213
    case patchyModerateSnow = 1216
    case moderateSnow = 1219
    case patchyHeavySnow = 1222
    case heavySnow = 1225
    case lightSnowShowers = 1255
    case moderateOrHeavySnowShowers = 1258
    
    case patchySleetPossible = 1069
    case patchyFreezingDrizzlePossible = 1072
    case icePellets = 1237
    case lightSleet = 1204
    case moderateOrHeavySleet = 1207
    case lightSleetShowers = 1249
    case moderateOrHeavySleetShowers = 1252
    case lightShowersOfIcePellets = 1261
    case moderateOrHeavyShowersOfIcePellets = 1264
    
    case thunderyOutbreaksPossible = 1087
    case patchyLightRainWithThunder = 1273
    case moderateOrHeavyRainWithThunder = 1276
    case patchyLightSnowWithThunder = 1279
    case moderateOrHeavySnowWithThunder = 1282

    var symbolName: String {
        switch self {
        case .clear:
            return "sun.max.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .cloudy:
            return "cloud.fill"
        case .overcast:
            return "smoke.fill"
        case .mist, .fog, .freezingFog:
            return "cloud.fog.fill"
        case .patchyLightDrizzle, .lightDrizzle, .freezingDrizzle, .heavyFreezingDrizzle:
            return "cloud.drizzle.fill"
        case .patchyRainPossible, .patchyLightRain, .lightRain, .lightRainShower:
            return "cloud.rain.fill"
        case .moderateRainAtTimes, .moderateRain, .moderateOrHeavyRainShower:
            return "cloud.heavyrain.fill"
        case .heavyRainAtTimes, .heavyRain, .torrentialRainShower:
            return "cloud.heavyrain.fill"
        case .lightFreezingRain, .moderateOrHeavyFreezingRain, .icePellets, .lightShowersOfIcePellets, .moderateOrHeavyShowersOfIcePellets:
            return "cloud.hail.fill"
        case .patchySleetPossible, .lightSleet, .moderateOrHeavySleet, .lightSleetShowers, .moderateOrHeavySleetShowers:
            return "cloud.sleet.fill"
        case .patchySnowPossible, .blowingSnow, .blizzard, .patchyLightSnow, .lightSnow, .patchyModerateSnow, .moderateSnow, .patchyHeavySnow, .heavySnow, .lightSnowShowers, .moderateOrHeavySnowShowers:
            return "snowflake"
        case .thunderyOutbreaksPossible, .patchyLightRainWithThunder, .moderateOrHeavyRainWithThunder:
            return "cloud.bolt.rain.fill"
        case .patchyLightSnowWithThunder, .moderateOrHeavySnowWithThunder:
            return "cloud.bolt.snow.fill"
        case .patchyFreezingDrizzlePossible:
            return "cloud.sleet.fill"
        }
    }
}

extension WeatherType {
    static func getSymbolConfig(for name: String) -> UIImage.SymbolConfiguration {
        let lowercasedName = name.lowercased()
        
        if lowercasedName.contains("cloud") && lowercasedName.contains("rain") {
            return UIImage.SymbolConfiguration(paletteColors: [.white, Theme.Colors.rainyTint])
        }
        
        if lowercasedName.contains("sun") && (lowercasedName.contains("cloud") || lowercasedName.contains("rain")) {
            return UIImage.SymbolConfiguration(paletteColors: [.white, .systemYellow])
        }
        
        if lowercasedName.contains("rain") || lowercasedName.contains("bolt") {
            return UIImage.SymbolConfiguration(hierarchicalColor: Theme.Colors.rainyTint)
        }
        
        if lowercasedName.contains("sun.max") {
            return UIImage.SymbolConfiguration(hierarchicalColor: .systemYellow)
        }
        
        return UIImage.SymbolConfiguration(hierarchicalColor: .white)
    }
}
