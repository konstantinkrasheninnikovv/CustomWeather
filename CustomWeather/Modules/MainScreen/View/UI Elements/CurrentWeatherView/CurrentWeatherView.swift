//
//  CurrentWeatherView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.03.2026.
//

import UIKit

struct CurrentWeatherViewModel {
    let topModel: CurrentWeatherTopViewModel
    let bottomModel: CurrentWeatherBottomViewModel
}

final class CurrentWeatherView: UIView {
    
    private let blurEffectView = AppGlassView()
    private let topView = CurrentWeatherTopView()
    private let separator = SeparatorView(color: .white.withAlphaComponent(0.3))
    private let bottomView = CurrentWeatherBottomView()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis  = .vertical
        stack.spacing = 20
        stack.alignment = .fill
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
    
    func configure(with model: CurrentWeatherViewModel) {
        topView.configure(with: model.topModel)
        bottomView.configure(with: model.bottomModel)
    }
    
}

private extension CurrentWeatherView {
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        addSubview(blurEffectView)
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(separator)
        mainStack.addArrangedSubview(bottomView)
        blurEffectView.addSubview(mainStack)
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -20),
            
            separator.widthAnchor.constraint(equalTo: mainStack.widthAnchor)
        ])
    }
}
