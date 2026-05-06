//
//  MainScreenCollectionViewCell.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 19.03.2026.
//

import UIKit

struct MainScreenHourlyWeatherSectionCellModel {
    let timeLabelModel: BaseLabelViewModel
    let tempLabelModel: BaseLabelViewModel
    let descLabelModel: BaseLabelViewModel
    let iconName: String
}

final class MainScreenHourlyWeatherSectionCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastCell"
    
    private let blurEffectView = AppGlassView(style: .thickStyle)
    private let timeLabel = BaseLabel()
    private let tempLabel = BaseLabel()
    private let descLabel = BaseLabel()
    private let iconImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
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
    
    // MARK: - Public Methods
    
    func configure(with model: MainScreenHourlyForecastWeatherModel) {
        
        let timeModelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: model.time)
        timeLabel.configure(with: timeModelStyle)
        
        let tempModelStyle = BaseLabelViewModel.weatherStyle(.bodyMedium, text: model.temperature)
        tempLabel.configure(with: tempModelStyle)
                        
        let descModelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: model.conditionDescription)
        descLabel.configure(with: descModelStyle)
                
        iconImageView.image = UIImage(systemName: model.iconImage, withConfiguration: model.iconConfig)
    }
}

    // MARK: - Layout

private extension MainScreenHourlyWeatherSectionCell {
    
    private func layoutSetup() {
        descLabel.adjustsFontSizeToFitWidth = true
        descLabel.minimumScaleFactor = 0.7
        descLabel.lineBreakMode = .byTruncatingTail
        configureLayout()
        configureSubviews()
        makeConstrains()
    }
    
    private func configureLayout() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        contentView.clipsToBounds = true
    }

    private func configureSubviews() {
        contentView.addSubview(blurEffectView)
        contentView.addSubview(stackView)
        
        [timeLabel, iconImageView, tempLabel, descLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 45),
            iconImageView.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
