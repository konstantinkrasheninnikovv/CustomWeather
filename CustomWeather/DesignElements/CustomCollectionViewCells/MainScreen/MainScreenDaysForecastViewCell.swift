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
    private let dateLabel = BaseLabel()
    private let weatherDescriptionLabel = BaseLabel()
    private let rainPossibilityLabel = BaseLabel()
    
    //MARK: - UI Stacks
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
        stack.distribution = .fill
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
    
    func configure(with model: MainScreenDaysForecastViewCellModel) {
        
        dayOfWeekLabel.configure(with: model.dayOfWeekLabelModel)
        dateLabel.configure(with: model.tempRangeLabelModel)
        weatherDescriptionLabel.configure(with: model.weatherDescriptionLabelModel)
        iconImageView.image = UIImage(systemName: model.iconImageName)
        rainPossibilityLabel.configure(with: model.rainPossibilityLabelModel)
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
        [dayOfWeekLabel, iconImageView, dateLabel, weatherDescriptionLabel, rainPossibilityLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            rainPossibilityLabel.heightAnchor.constraint(equalToConstant: 16),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
