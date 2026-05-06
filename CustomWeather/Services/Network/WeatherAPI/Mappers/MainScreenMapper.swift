//
//  MainScreenMapper.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.04.2026.
//

import Foundation

struct MainScreenMapper {
    
    static func mapCurrentWeather(_ data: CurrentWeather) -> CurrentWeatherModel {
        let weatherCode = data.condition.weatherCode
        let iconName = WeatherType(rawValue: weatherCode)?.symbolName ?? "questionmark.circle"
        let imageConfig = WeatherType.getSymbolConfig(for: iconName)
        
        let currentWeatherModel = CurrentWeatherModel(
            tempC: String(format: "%.0f", data.tempC) + "°C",
            feelsLikeC: Localizable.MainScreen.feelsLike.uppercased() + " " + String(format: "%.0f", data.feelslikeC) + "°C",
            conditionDescription: data.condition.conditionDescription,
            iconImage: iconName,
            iconConfig: imageConfig,
            pressure: "\(data.pressure) hPa",
            windSpeed: "\(data.windSpeed) Km/h",
            humidity: "\(data.humidity)%"
        )
        return currentWeatherModel
    }
    
    static func mapHourlyData(_ hours: [Hour]) -> [MainScreenHourlyForecastWeatherModel] {
        hours.map { mapSingleHour($0) }
    }
    
    private static func mapSingleHour(_ data: Hour) -> MainScreenHourlyForecastWeatherModel {
        let weatherCode = data.condition.weatherCode
        let iconImageName = WeatherType(rawValue: weatherCode)?.symbolName ?? "questionmark.circle"
        let imageConfig = WeatherType.getSymbolConfig(for: iconImageName)

        let temperature = String(format: "%.0f", data.tempC) + "°C"
        let conditionDescription = data.condition.conditionDescription
        let formattedTime = formatTime(data.time)
        
        return MainScreenHourlyForecastWeatherModel(
            time: formattedTime,
            iconImage: iconImageName,
            iconConfig: imageConfig,
            temperature: temperature,
            conditionDescription: conditionDescription)
    }
    
    private static func formatTime(_ dateString: String) -> String {
            let components = dateString.components(separatedBy: " ")
            return components.last ?? dateString
        }
    
    static func mapDaysData(_ days: [ForecastDay]) -> [MainScreenDaysForecastWeatherModel] {
        days.map { mapSingleDay($0) }
    }
    
    private static func mapSingleDay(_ forecastDay: ForecastDay) -> MainScreenDaysForecastWeatherModel {
        let dayName = getDayName(from: forecastDay.date)
        
        let weatherCode = forecastDay.day.condition.weatherCode
        let imageName = WeatherType(rawValue: weatherCode)?.symbolName ?? "questionmark.circle"
        let imageConfig = WeatherType.getSymbolConfig(for: imageName)
        
        let temprerature = String(format: "%.0f", forecastDay.day.maxTempC) + " / " +  String(format: "%.0f", forecastDay.day.minTempC)
        
        var rainChance: String? = nil
        var description: String? = nil
        
        if forecastDay.day.rainChance > 0 {
            rainChance = "\(forecastDay.day.rainChance)%"
        } else {
            description = forecastDay.day.condition.conditionDescription
        }
        return MainScreenDaysForecastWeatherModel(
            date: dayName,
            iconImageName: imageName,
            temp: temprerature,
            iconConfig: imageConfig,
            conditionDescription: description,
            rainChance: rainChance)
    }
}

private extension MainScreenMapper {
    
    // MARK: - Day Formatter

    private static func getDayName(from dateString: String) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = inputFormatter.date(from: dateString) else { return dateString }
        let dayName = DateFormatter.dayOfWeek.string(from: date)
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        return dayName.capitalized
    }
}
