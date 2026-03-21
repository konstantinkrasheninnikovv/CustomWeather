//
//  AppGlassView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 19.03.2026.
//

import UIKit

final class AppGlassView: UIView {
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AppGlassView {
    
    private func setupView() {
        configureLayer()
        configureSubviews()
        makeConstrains()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    private func configureSubviews() {
        addSubview(blurEffectView)
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    blurEffectView.topAnchor.constraint(equalTo: topAnchor),
                    blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
    }
}
