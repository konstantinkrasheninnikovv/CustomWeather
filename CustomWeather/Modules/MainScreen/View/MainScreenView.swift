//
//  MainScreenView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenViewProtocol: UIView {
    var delegate: MainScreenViewDelegate? { get set }
    func setCollectionViewDataSourseAndDelegate(
        dataSource: UICollectionViewDataSource,
        delegate: UICollectionViewDelegate
    )
}

final class MainScreenView: UIView, MainScreenViewProtocol {
    
    weak var delegate: MainScreenViewDelegate?
    
    // MARK: - UI Objects
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(MainScreenHourlyWeatherSectionCell.self,
                    forCellWithReuseIdentifier: MainScreenHourlyWeatherSectionCell.identifier)
        return cv
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setCollectionViewDataSourseAndDelegate( dataSource: UICollectionViewDataSource,
                                                 delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
}

     // MARK: - Layout

private extension MainScreenView {
    private func setupUI() {
        configureSubviews()
        makeConstrains()
        backgroundColor = .systemBlue
    }
    
    private func configureSubviews() {
        addSubview(collectionView)
    }
    
    private func makeConstrains() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
