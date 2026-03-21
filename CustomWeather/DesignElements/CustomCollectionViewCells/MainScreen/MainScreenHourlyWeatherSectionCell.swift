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
    
    private let blurEffectView = AppGlassView()
    private let timeLabel = BaseLabel()
    private let tempLabel = BaseLabel()
    private let descLabel = BaseLabel()
    private let iconImageView = UIImageView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        return stack
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with model: MainScreenHourlyWeatherSectionCellModel) {
        timeLabel.configure(with: model.timeLabelModel)
        tempLabel.configure(with: model.tempLabelModel)
        descLabel.configure(with: model.descLabelModel)
        
        iconImageView.image = UIImage(named: model.iconName)
    }
}

    // MARK: - Layout

private extension MainScreenHourlyWeatherSectionCell {
    
    private func setupUI() {
        configureSubviews()
        makeConstrains()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }

    private func configureSubviews() {
        contentView.addSubview(blurEffectView)
        contentView.addSubview(stackView)
        
        [timeLabel, iconImageView, tempLabel, descLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
  
        //MARK: -        // Check the BEHAVIOR!!

        blurEffectView.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 120),
            iconImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
