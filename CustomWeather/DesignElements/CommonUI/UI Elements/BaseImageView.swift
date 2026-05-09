//
//  LocationImageTopView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 07.04.2026.
//

import UIKit

protocol BaseImageViewModelProtocol {
    var imageName: String? { get set }
    var image: UIImage? { get set }
    var placeholder: UIImage? { get set }
}

struct BaseImageViewModel: BaseImageViewModelProtocol {
    var imageName: String?
    var image: UIImage?
    var placeholder: UIImage?
}

protocol BaseImageViewProtocol {
    func configure(with model: BaseImageViewModelProtocol, color: UIColor?)
}

final class BaseImageView: UIView, BaseImageViewProtocol {
    
    //MARK: - UI Elements
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    //MARK: - Actions
    
    func configure(with model: BaseImageViewModelProtocol, color: UIColor? = nil) {
        
        if let image = model.image, let color = color {
            UIView.transition(with: self.imageView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.imageView.image = image
                self.updateGradient(with: color)
            })
        } else if let name = model.imageName {
            imageView.image = UIImage(named: name)
        } else {
            imageView.image = model.placeholder
        }
    }
}

private extension BaseImageView {
    
    private func setupLayout() {
        setupSubviews()
        makeConstrains()
        setupGradient()
    }
    
    private func setupGradient() {
            gradientLayer.locations = [0.0, 0.5, 1.0]
            
            gradientLayer.colors = [
                UIColor.clear.cgColor,
                UIColor.clear.cgColor,
                UIColor.clear.cgColor
            ]
            layer.addSublayer(gradientLayer)
        }
    
    private func updateGradient(with color: UIColor) {
        let newColors = [
            UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor,
            color.cgColor
        ]
            self.gradientLayer.colors = newColors
    }
    
    private func setupSubviews() {
        addSubview(imageView)
    }
    
    private func makeConstrains() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
