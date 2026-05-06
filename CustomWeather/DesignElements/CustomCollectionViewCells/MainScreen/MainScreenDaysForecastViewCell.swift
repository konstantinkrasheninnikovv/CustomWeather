//
//  MainScreenDaysForecastViewCell.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 09.04.2026.
//

import UIKit

struct MainScreenDaysForecastViewCellModel {
    let dayOfWeekLabelModel: BaseLabelViewModel
    let tempRangeLabelModel: BaseLabelViewModel
    let weatherDescriptionLabelModel: BaseLabelViewModel
    let rainPossibilityLabelModel: BaseLabelViewModel
    let iconImageName: String
}

final class MainScreenDaysForecastViewCell: UICollectionViewCell {
    
    static let identifier = "MainScreenDaysForecastViewCell"
    
    //MARK: - UI Elements
    
    private let dayOfWeekLabel = BaseLabel()
    private let iconImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let avgTemperatureLabel = BaseLabel()
    private let weatherDescriptionLabel = BaseLabel()
    
    //MARK: - UI Stacks
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
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
    
    //MARK: - Public functions
    
    func configure(with model: MainScreenDaysForecastWeatherModel) {
        
        let dayOfWeekModelStyle = BaseLabelViewModel.weatherStyle(.bodyMedium, text: model.date)
        dayOfWeekLabel.configure(with: dayOfWeekModelStyle)
        
        let avgTemperatureModelStyle = BaseLabelViewModel.weatherStyle(.bodyMedium, text: model.temp)
        avgTemperatureLabel.configure(with: avgTemperatureModelStyle)
        
        iconImageView.image = UIImage(systemName: model.iconImageName, withConfiguration: model.iconConfig)
        
        if let rainChance = model.rainChance {
            let rainPossibilityModelStyle = BaseLabelViewModel.weatherStyle(.labelRain, text: rainChance)
            weatherDescriptionLabel.configure(with: rainPossibilityModelStyle)
        } else {
            let weatherDescriptionModelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: model.conditionDescription ?? "")
            weatherDescriptionLabel.configure(with: weatherDescriptionModelStyle)
        }
    }
}

private extension MainScreenDaysForecastViewCell {
    
    private func layoutSetup() {
        configureLayout()
        configureSubviews()
        makeConstrains()
    }
    
    private func configureLayout() {
        contentView.backgroundColor = .clear
    }
    
    private func configureSubviews() {
        contentView.addSubview(stackView)
        [dayOfWeekLabel, iconImageView, avgTemperatureLabel, weatherDescriptionLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
