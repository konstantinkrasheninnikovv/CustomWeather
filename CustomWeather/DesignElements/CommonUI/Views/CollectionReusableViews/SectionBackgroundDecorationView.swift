//
//  File.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 10.04.2026.
//

import UIKit

final class SectionBackgroundDecorationView: UICollectionReusableView {

    static let backgroundIdentifier = "SectionBackground"
    
    private let glassView = AppGlassView(style: .thickStyle)
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SectionBackgroundDecorationView {
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        glassView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(glassView)
    }
    
    private func makeConstrains() {
        NSLayoutConstraint.activate([
            glassView.topAnchor.constraint(equalTo: topAnchor),
            glassView.leadingAnchor.constraint(equalTo: leadingAnchor),
            glassView.trailingAnchor.constraint(equalTo: trailingAnchor),
            glassView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
