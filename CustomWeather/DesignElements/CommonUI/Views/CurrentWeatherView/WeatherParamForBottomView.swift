//
//  WeatherParamBottomView.swift
//  CustomWeather
//
//  Created by Konsntantin Krasheninnikov on 22.03.2026.
//

import UIKit

struct WeatherParamForBottomViewModel {
    let titleModel: BaseLabelViewModel
    let valueModel: BaseLabelViewModel
    let iconNameImageModel: String
}

final class WeatherParamForBottomView : UIView {
    
    //MARK: - UI Elements
    
    private let titleLabel = BaseLabel()
    
    private let valueLabel = {
        let label = BaseLabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconView = UIImageView()
    
    //MARK: - UI Stacks
    
    private lazy var mainHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
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
    
    func configure(type: WeatherParamType, parameterValue: String) {
        
        let titleLabelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: type.title)
        titleLabel.configure(with: titleLabelStyle)
        
        let valueLabelStyle = BaseLabelViewModel.weatherStyle(.labelValue, text: parameterValue)
        valueLabel.configure(with: valueLabelStyle)
        
        iconView.image = UIImage(systemName: type.iconName)
    }
}

private extension WeatherParamForBottomView {
    
    //MARK: - Setup UI
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        addSubview(mainHorizontalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(valueLabel)
        mainHorizontalStack.addArrangedSubview(iconView)
        mainHorizontalStack.addArrangedSubview(verticalStack)
    }
    
    private func makeConstrains() {
        mainHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainHorizontalStack.topAnchor.constraint(equalTo: topAnchor),
            mainHorizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainHorizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHorizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
