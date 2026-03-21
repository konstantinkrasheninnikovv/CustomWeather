//
//  MainScreenViewManager.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 18.03.2026.
//

import UIKit

protocol HourlyWeatherSectionProtocol: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var hourlyCells: [MainScreenHourlyWeatherSectionCellModel] { get set }
    var collectionView: UICollectionView? { get set }
}

protocol MainScreenViewManagerProtocol: HourlyWeatherSectionProtocol {
}

final class MainScreenViewManager: NSObject, MainScreenViewManagerProtocol {
    
    // MARK: - Properties

    weak var collectionView: UICollectionView?
    var hourlyCells: [MainScreenHourlyWeatherSectionCellModel] = []
            
}

// MARK: - HourlyWeatherSection (Collection View) Implementation

extension MainScreenViewManager: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenHourlyWeatherSectionCell.identifier, for: indexPath) as? MainScreenHourlyWeatherSectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: hourlyCells[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 130)
    }
    
}
