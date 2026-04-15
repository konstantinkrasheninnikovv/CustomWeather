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

struct AirQualitySectionCellModel {
    let aqi: GaugeValueModel
    let pollen: GaugeValueModel
    let uv: GaugeValueModel
}

final class AirQualitySectionCell: UICollectionViewCell {
    
    static let identifier = "AirQualitySectionCell"
    
    //MARK: - UI Elements
    
    private let aqiGauge = GaugeElementView()
    private let pollenGauge = GaugeElementView()
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
    
    func configure (with model: AirQualitySectionCellModel) {
        
        aqiGauge.configureWithText(
            title: model.aqi.title,
            value: model.aqi.value,
            subtitle: model.aqi.subtitle,
            progress: model.aqi.progress,
            color: model.aqi.color,
            status: model.aqi.status,
            desc: model.aqi.description
        )
        
        pollenGauge.configureWithTextAndIcon(
            image: UIImage(systemName: model.pollen.iconName ?? ""),
            subtitle: model.pollen.subtitle,
            progress: model.pollen.progress,
            color: model.pollen.color,
            status: model.pollen.status,
            desc: model.pollen.description
        )
        
        uvGauge.configureWithTextAndIcon(
            image: UIImage(systemName: model.uv.iconName ?? ""),
            subtitle: model.uv.subtitle,
            progress: model.uv.progress,
            color: model.uv.color,
            status: model.uv.status,
            desc: model.uv.description
        )
    }
}

private extension AirQualitySectionCell {
    
    private func layoutSetup() {
        contentView.backgroundColor = .clear
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        contentView.addSubview(mainHorizStack)
        [aqiGauge, pollenGauge, uvGauge].forEach{ mainHorizStack.addArrangedSubview($0) }
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
