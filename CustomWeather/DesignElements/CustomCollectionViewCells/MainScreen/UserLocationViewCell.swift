//
//  TopLocationView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 29.04.2026.
//

import UIKit

final class UserLocationViewCell: UICollectionViewCell {
    
    static let identifier = "TopLocationViewCell"
    
    //MARK: - UI Elements
    
    private let blurEffectView = AppGlassView(style: .thinStyle)
    
    private let locationLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textColor = .white
        label.text = "Limassol, Cyprus"
        return label
    }()
    
    private let timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "2:56"
        return label
    }()
    
    private lazy var locationButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        return button
    }()
    
    private lazy var searchButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - UI Stacks
    
    private lazy var vertStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stack.spacing = 0
        return stack
    }()
    
    private lazy var mainHorStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button actions
    
    @objc func handleSearchButton(sender: UIButton) {

       // Move to another screen!!
    }
    
}

private extension UserLocationViewCell {
    
    private func setupLayout() {
        setupSubviews()
        makeConstrains()
        backgroundColor = .clear
    }
    
    private func setupSubviews() {
        addSubview(blurEffectView)
        addSubview(locationButton)
        addSubview(vertStack)
        addSubview(searchButton)
        vertStack.addArrangedSubview(locationLabel)
        vertStack.addArrangedSubview(timeLabel)
    }
    
    private func makeConstrains() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        vertStack.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            locationButton.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            locationButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationButton.widthAnchor.constraint(equalToConstant: 36),
            locationButton.heightAnchor.constraint(equalTo: locationButton.widthAnchor),
            
            vertStack.topAnchor.constraint(equalTo: topAnchor),
            vertStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vertStack.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor),
            
            searchButton.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchButton.heightAnchor.constraint(equalToConstant: 42),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor)

        ])
    }
}

