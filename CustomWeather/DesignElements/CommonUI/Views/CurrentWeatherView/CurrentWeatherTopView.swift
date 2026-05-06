//
//  CurrentWeatherTopView.swift
//  CustomWeather
//
//  Created by Konsntantin Krasheninnikov on 21.03.2026.
//

import UIKit

struct CurrentWeatherTopViewModel {
    let tempModel: String
    let conditionModel: String
    let feelsLikeModel: String
    let mainIconImageModel: String
}

final class CurrentWeatherTopView: UIView {
    
    //MARK: - UI Elements
    
    private let tempLabel = {
        let label = BaseLabel()
        return label
    }()
    
    private let conditionLabel = {
        let label = BaseLabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let feelsLikeLabel = BaseLabel()
    private let mainIconView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let spacer = UIView()
    
    //MARK: - UI Stacks
    
    private lazy var mainHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
//        stack.alignment = .center
        stack.spacing = 2
        return stack
    }()
    
    private lazy var vertStackForConditionLabel = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 2
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
    
    func configure(with model: CurrentWeatherModel) {
        
        let tempModelStyle = BaseLabelViewModel.weatherStyle(.display, text: model.tempC)
        tempLabel.configure(with: tempModelStyle)
        
        let conditionModelStyle = BaseLabelViewModel.weatherStyle(.titleLarge, text: model.conditionDescription)
        conditionLabel.configure(with: conditionModelStyle)

        let feelsLikeModelStyle = BaseLabelViewModel.weatherStyle(.titleMedium, text: model.feelsLikeC)
        feelsLikeLabel.configure(with: feelsLikeModelStyle)
        
        mainIconView.image = UIImage(systemName: model.iconImage, withConfiguration: model.iconConfig)
    }
}

private extension CurrentWeatherTopView {
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        addSubview(mainHorizontalStack)
        verticalStack.addArrangedSubview(tempLabel)
        verticalStack.addArrangedSubview(feelsLikeLabel)
        mainHorizontalStack.addArrangedSubview(verticalStack)
        mainHorizontalStack.addArrangedSubview(vertStackForConditionLabel)
        vertStackForConditionLabel.addArrangedSubview(spacer)
        vertStackForConditionLabel.addArrangedSubview(conditionLabel)
        mainHorizontalStack.addArrangedSubview(mainIconView)
        
        feelsLikeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        tempLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

    }
    
    private func makeConstrains() {
        mainHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
//        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainHorizontalStack.topAnchor.constraint(equalTo: topAnchor),
            mainHorizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHorizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHorizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            feelsLikeLabel.lastBaselineAnchor.constraint(equalTo: conditionLabel.lastBaselineAnchor),
                                    
            mainIconView.heightAnchor.constraint(equalTo: verticalStack.heightAnchor, multiplier: 0.8),
            mainIconView.widthAnchor.constraint(equalTo: mainIconView.heightAnchor)
        ])
    }
}
