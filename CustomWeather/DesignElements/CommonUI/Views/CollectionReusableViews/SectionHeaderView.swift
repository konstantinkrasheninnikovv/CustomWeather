//
//  SectionHeaderView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 11.04.2026.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderView"
    
    private let titleLabel = BaseLabel()

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with text: String) {
        let model = BaseLabelViewModel(
            text: text.uppercased(),
            font: .systemFont(ofSize: 13, weight: .medium),
            textColor: .white.withAlphaComponent(0.6)
        )
        titleLabel.configure(with: model)
    }
}

private extension SectionHeaderView {
    
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func makeConstrains() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
