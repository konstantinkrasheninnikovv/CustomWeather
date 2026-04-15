//
//  CurrentWeatherTopView.swift
//  CustomWeather
//
//  Created by Konsntantin Krasheninnikov on 21.03.2026.
//

import UIKit

struct CurrentWeatherTopViewModel {
    let tempModel: BaseLabelViewModel
    let conditionModel: BaseLabelViewModel
    let feelsLikeModel: BaseLabelViewModel
    let mainIconImageModel: String
}

final class CurrentWeatherTopView: UIView {
    
    private let tempLabel = {
        let label = BaseLabel()
        return label
    }()
    
    private let conditionLabel = {
       let label = BaseLabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let feelsLikeLabel = BaseLabel()
    
    private let mainIconView = UIImageView()
    
    private lazy var mainHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 2
        stack.alignment = .leading
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
    
    func configure(with model: CurrentWeatherTopViewModel) {
        tempLabel.configure(with: model.tempModel)
        conditionLabel.configure(with: model.conditionModel)
        feelsLikeLabel.configure(with: model.feelsLikeModel)
        mainIconView.image = UIImage(systemName: model.mainIconImageModel)
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
        mainHorizontalStack.addArrangedSubview(conditionLabel)
        mainHorizontalStack.addArrangedSubview(mainIconView)
        
        tempLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func makeConstrains() {
        mainHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainHorizontalStack.topAnchor.constraint(equalTo: topAnchor),
            mainHorizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHorizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHorizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),

            mainIconView.heightAnchor.constraint(equalTo: verticalStack.heightAnchor, multiplier: 0.8),
            mainIconView.widthAnchor.constraint(equalTo: mainIconView.heightAnchor)
        ])
    }
}
