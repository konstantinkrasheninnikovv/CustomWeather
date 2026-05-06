//
//  AirQualitySectionCell.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 13.04.2026.
//

import UIKit

struct GaugeValueModel {
    let title: String
    let value: String
    let subtitle: String
    let progress: CGFloat
    let color: UIColor
    let status: String
    let description: String
    let iconName: String?
}

struct MainScreenEnvironmentalMetricsCellModel {
    let aqi: GaugeValueModel
    let visibility: GaugeValueModel
    let uv: GaugeValueModel
}

final class MainScreenEnvironmentalMetricsCell: UICollectionViewCell {
    
    static let identifier = "EnvironmentalMetricsSectionCell"
    
    //MARK: - UI Elements
    
    private let aqiGauge = GaugeElementView()
    private let visibilityGauge = GaugeElementView()
    private let uvGauge = GaugeElementView()
    
    //MARK: - UI Stacks
    
    private lazy var mainHorizStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func configure (with model: MainScreenEnvironmentalMetricsModel) {
        aqiGauge.configure(with: model.aqiModel)
        visibilityGauge.configure(with: model.visibilityModel)
        uvGauge.configure(with: model.uvMetricModel)
    }
}

private extension MainScreenEnvironmentalMetricsCell {
    
    private func layoutSetup() {
        contentView.backgroundColor = .clear
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        contentView.addSubview(mainHorizStack)
        [aqiGauge, visibilityGauge, uvGauge].forEach{ mainHorizStack.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        mainHorizStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainHorizStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainHorizStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainHorizStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainHorizStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
