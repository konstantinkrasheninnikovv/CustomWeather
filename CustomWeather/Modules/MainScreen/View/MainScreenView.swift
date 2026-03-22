//
//  MainScreenView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenViewProtocol: UIView {
    var delegate: MainScreenViewDelegate? { get set }
    func reloadInfo()
    func assignManager(_ manager: UICollectionViewDataSource & UICollectionViewDelegate)
    func displayCurrentWeather(_ model: CurrentWeatherViewModel)
}

final class MainScreenView: UIView, MainScreenViewProtocol {

    weak var delegate: MainScreenViewDelegate?

    // MARK: - UI Objects
    
    private lazy var currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 85, height: 160)
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func assignManager(_ manager: UICollectionViewDataSource & UICollectionViewDelegate) {
            collectionView.dataSource = manager
            collectionView.delegate = manager
        }
    
    func reloadInfo() {
        collectionView.reloadData()
    }
    
    func displayCurrentWeather(_ model: CurrentWeatherViewModel) {
        currentWeatherView.configure(with: model)
    }
}

     // MARK: - Layout

private extension MainScreenView {
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
        backgroundColor = .systemBlue
    }
    
    private func configureSubviews() {
        addSubview(currentWeatherView)
        addSubview(collectionView)
    }
    
    private func makeConstrains() {
        currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentWeatherView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            currentWeatherView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentWeatherView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}
