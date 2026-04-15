//
//  MainScreenViewManager.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.03.2026.
//

import UIKit
import MapKit

protocol MainScreenViewManagerProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var currentWeatherCellViewModel: CurrentWeatherCellViewModel? { get set }
    var hourlyCells: [MainScreenHourlyWeatherSectionCellModel] { get set }
    var daysForecastCells: [MainScreenDaysForecastViewCellModel] { get set }
    var airQualitySectionCell: AirQualitySectionCellModel? { get set }
    var collectionView: UICollectionView? { get set }
}

final class MainScreenViewManager: NSObject, MainScreenViewManagerProtocol {
    
    // MARK: - Properties

    var currentWeatherCellViewModel: CurrentWeatherCellViewModel?
    var hourlyCells: [MainScreenHourlyWeatherSectionCellModel] = []
    var daysForecastCells: [MainScreenDaysForecastViewCellModel] = []
    var airQualitySectionCell: AirQualitySectionCellModel?
    
    weak var collectionView: UICollectionView?

}

// MARK: - UICollectionViewDataSource

extension MainScreenViewManager: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return currentWeatherCellViewModel == nil ? 0 : 1
        case 1:
            return hourlyCells.count
        case 2:
            return daysForecastCells.count
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherViewCell.identifier, for: indexPath) as? CurrentWeatherViewCell else { return UICollectionViewCell() }
            if let model = currentWeatherCellViewModel {
                cell.configure(with: model)
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenHourlyWeatherSectionCell.identifier, for: indexPath) as? MainScreenHourlyWeatherSectionCell else { return UICollectionViewCell() }
            cell.configure(with: hourlyCells[indexPath.item])
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenDaysForecastViewCell.identifier, for: indexPath) as? MainScreenDaysForecastViewCell else { return UICollectionViewCell() }
            cell.configure(with: daysForecastCells[indexPath.item])
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenRadarViewCell.identifier, for: indexPath) as? MainScreenRadarViewCell else { return UICollectionViewCell() }
            
            // Get it from Presenter!!!
            
            let model = MainScreenRadarViewCellModel(
                locationName: "Limassol",
                centerCoordinate: CLLocationCoordinate2D(latitude: 34.6783, longitude: 33.0412)
            )
            
            cell.configure(with: model)
            return cell
            
        case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirQualitySectionCell.identifier, for: indexPath) as? AirQualitySectionCell else { return UICollectionViewCell() }
            
            if let model = airQualitySectionCell {
                cell.configure(with: model)
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath
            ) as? SectionHeaderView else {
                return UICollectionReusableView()
            }
            
            switch indexPath.section {
            case 1: header.configure(with: "Forecast for now")
            case 2: header.configure(with: "7-Day Forecast")
            case 3: header.configure(with: "Live Precipitation Radar")
            case 4: header.configure(with: "Air Quality Index and Pollen")
            default: break
            }
            
            return header
        }
        return UICollectionReusableView()
    }
}
