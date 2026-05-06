//
//  AppGlassView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 19.03.2026.
//

import UIKit

final class AppGlassView: UIView {
    
    // MARK: - Glass UI Setup
    
    enum GlassStyle {
        case thinStyle
        case thickStyle
        
        var blurStyle : UIBlurEffect.Style {
            switch self {
            case .thinStyle: return .systemUltraThinMaterial
            case .thickStyle: return .systemUltraThinMaterialLight
            }
        }
        
        var tintAlpha: CGFloat {
            switch self {
            case .thinStyle: return 0.03
            case .thickStyle: return 0.5
            }
        }
        
        var alphaIntencity: CGFloat {
            switch self {
            case .thinStyle: return 0.2
            case .thickStyle: return 0.8
            }
        }
        
    }
    
    private let style: GlassStyle
    private let blurEffectView = UIVisualEffectView()
    private let tintView = UIView()
    
    // MARK: - Initialization
    
    init(style: GlassStyle) {
        self.style = style
        super.init(frame: .zero)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AppGlassView {
    
    private func layoutSetup() {
        configureLayer()
        configureSubviews()
        makeConstrains()
    }
    
    private func configureLayer() {
        blurEffectView.effect = UIBlurEffect(style: style.blurStyle)
        tintView.backgroundColor = UIColor.black.withAlphaComponent(style.tintAlpha)
        blurEffectView.alpha = style.alphaIntencity
        
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    }
    
    private func configureSubviews() {
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(tintView)
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        tintView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tintView.topAnchor.constraint(equalTo: blurEffectView.contentView.topAnchor),
            tintView.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor),
            tintView.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor),
            tintView.bottomAnchor.constraint(equalTo: blurEffectView.contentView.bottomAnchor)
        ])
    }
}
