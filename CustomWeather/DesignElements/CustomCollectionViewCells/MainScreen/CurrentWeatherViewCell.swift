//
//  CurrentWeatherView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.03.2026.
//

import UIKit

struct CurrentWeatherCellViewModel {
    let topModel: CurrentWeatherTopViewModel
    let bottomModel: CurrentWeatherBottomViewModel
}

final class CurrentWeatherViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentWeatherViewCell"
    
    // MARK: - UI Elements
    
    private let blurEffectView = AppGlassView(style: .thickStyle)
    private let topView = CurrentWeatherTopView()
    private let separator = SeparatorView(color: .white.withAlphaComponent(0.3))
    private let bottomView = CurrentWeatherBottomView()
    
    //MARK: - UI Stacks
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis  = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 10)
        stack.spacing = 5
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
    
    // MARK: - Public Methods
    
    func configure(with model: CurrentWeatherModel) {
        topView.configure(with: model)
        bottomView.configure(with: model)
    }
}

private extension CurrentWeatherViewCell {
    
    private func layoutSetup() {
        backgroundColor = .clear
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        contentView.addSubview(blurEffectView)
        blurEffectView.addSubview(mainStack)
        mainStack.addArrangedSubview(topView)
        mainStack.addArrangedSubview(separator)
        mainStack.addArrangedSubview(bottomView)
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
            
            mainStack.topAnchor.constraint(equalTo: blurEffectView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor),
        ])
    }
}
