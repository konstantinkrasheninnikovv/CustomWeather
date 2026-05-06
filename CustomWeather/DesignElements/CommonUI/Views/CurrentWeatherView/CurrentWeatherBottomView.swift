//
//  WeatherParamView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.03.2026.
//

import UIKit

struct CurrentWeatherBottomViewModel {
    let windModel: WeatherParamForBottomViewModel
    let humidityModel: WeatherParamForBottomViewModel
    let pressureModel: WeatherParamForBottomViewModel
}

final class CurrentWeatherBottomView: UIView {
    
    private lazy var windParam = WeatherParamForBottomView()
    private lazy var humidityParam = WeatherParamForBottomView()
    private lazy var pressureParam = WeatherParamForBottomView()
    
    private lazy var mainStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 12
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
        windParam.configure(type: .wind, parameterValue: model.windSpeed)
        humidityParam.configure(type: .humidity, parameterValue: model.humidity)
        pressureParam.configure(type: .pressure, parameterValue: model.pressure)
    }
}

private extension CurrentWeatherBottomView {
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        addSubview(mainStack)
        [windParam, humidityParam, pressureParam].forEach { mainStack.addArrangedSubview($0) }
    }
    
    private func makeConstrains() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
