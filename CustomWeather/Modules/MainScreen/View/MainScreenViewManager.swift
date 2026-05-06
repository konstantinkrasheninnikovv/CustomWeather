//
//  MainScreenViewManager.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.03.2026.
//

import UIKit
import MapKit

protocol MainScreenViewManagerProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var currentWeatherModel: CurrentWeatherModel? { get set }
    var hourlyForecastModels: [MainScreenHourlyForecastWeatherModel] { get set }
    var daysForecastModels: [MainScreenDaysForecastWeatherModel] { get set }
    var environmentalMetricsCell: MainScreenEnvironmentalMetricsModel? { get set }
    var collectionView: UICollectionView? { get set }
}

final class MainScreenViewManager: NSObject, MainScreenViewManagerProtocol {
    
    // MARK: - Properties
    
    var currentWeatherModel: CurrentWeatherModel?
    var hourlyForecastModels: [MainScreenHourlyForecastWeatherModel] = []
    var daysForecastModels: [MainScreenDaysForecastWeatherModel] = []
    var environmentalMetricsCell: MainScreenEnvironmentalMetricsModel?
    
    weak var collectionView: UICollectionView?
    
}

// MARK: - UICollectionViewDataSource

extension MainScreenViewManager: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainScreenSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        guard let sectionType = MainScreenSection(rawValue: section) else { return 0 }
            
        switch sectionType {
        case .userLocation: return 1
        case .currentWeather: return currentWeatherModel == nil ? 0 : 1
        case .hourlyForecast: return hourlyForecastModels.count
        case .daysForecast: return daysForecastModels.count
        case .radarForecast: return 1
        case .environmentalMetrics: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sectionType = MainScreenSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionType.cellIdentifier, for: indexPath)
        
        switch sectionType {
        case .userLocation:
            return (cell as? UserLocationViewCell)!
        case .currentWeather:
            if let model = currentWeatherModel {
                (cell as? CurrentWeatherViewCell)?.configure(with: model)
            }
            return cell
        case .hourlyForecast:
            let model = hourlyForecastModels[indexPath.item]
            (cell as? MainScreenHourlyWeatherSectionCell)?.configure(with: model)
            return cell
        case .daysForecast:
            let model = daysForecastModels[indexPath.item]
            (cell as? MainScreenDaysForecastViewCell)?.configure(with: model)
            return cell
        case .radarForecast:
            
            // Get it from Presenter! - TO DO!!
            
            let model = MainScreenRadarViewCellModel(
                locationName: "Limassol",
                centerCoordinate: CLLocationCoordinate2D(latitude: 34.6783, longitude: 33.0412)
            )
            
            (cell as? MainScreenRadarViewCell)?.configure(with: model)
            return cell
            
        case .environmentalMetrics:
            if let model = environmentalMetricsCell {
                (cell as? MainScreenEnvironmentalMetricsCell)?.configure(with: model)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader,
              let sectionType = MainScreenSection(rawValue: indexPath.section),
              let headerTitle = sectionType.headerTitle else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as? SectionHeaderView
        
        header?.configure(with: headerTitle)
        return header ?? UICollectionReusableView()
    }
}
