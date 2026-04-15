//
//  LocationImageTopView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 07.04.2026.
//

import UIKit

protocol BaseImageViewModelProtocol {
    var imageName: String? { get set }
    var imageURL: URL? { get set }
    var placeholder: UIImage? { get set }
}

struct BaseImageViewModel: BaseImageViewModelProtocol {
    var imageName: String?
    var imageURL: URL? = nil
    var placeholder: UIImage?
}

protocol BaseImageViewProtocol {
    func configure(with model: BaseImageViewModelProtocol)
}

final class BaseImageView: UIView, BaseImageViewProtocol {
    
    //MARK: - UI Elements
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let overlayView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    func configure(with model: BaseImageViewModelProtocol) {
        if let name = model.imageName {
            imageView.image = UIImage(named: name)
        } else if let url = model.imageURL {
            
            // Networking request here - to DO!
            
            imageView.image = model.placeholder
            
        } else {
            imageView.image = model.placeholder
        }
    }
}

private extension BaseImageView {
    
    private func setupLayout() {
        setupSubviews()
        makeConstrains()
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        addSubview(overlayView)
    }
    
    private func makeConstrains() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
