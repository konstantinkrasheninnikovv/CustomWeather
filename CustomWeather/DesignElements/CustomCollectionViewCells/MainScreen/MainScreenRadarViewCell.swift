//
//  MainScreenRadarViewCell.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 11.04.2026.
//

import UIKit
import MapKit

struct MainScreenRadarViewCellModel {
    let locationName: String
    let centerCoordinate: CLLocationCoordinate2D
}

final class MainScreenRadarViewCell: UICollectionViewCell {
    
    static let identifier = "MainScreenRadarViewCell"
    
    //MARK: - UI Elements
    
    private lazy var mapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 20
        map.clipsToBounds = true
        map.isUserInteractionEnabled = false // temporarily
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods

    func configure(with model: MainScreenRadarViewCellModel) {
        let region = MKCoordinateRegion(
            center: model.centerCoordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 50000)
        mapView.setRegion(region, animated: false)
    }
    
}

private extension MainScreenRadarViewCell {
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
        makeMapSetup()
    }
    
    private func configureSubviews() {
        contentView.addSubview(mapView)
    }
    
    private func makeConstrains() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func makeMapSetup() {
        let center = CLLocationCoordinate2D(latitude: 34.6783, longitude: 33.0412)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.setRegion(region, animated: false)
    }
}
