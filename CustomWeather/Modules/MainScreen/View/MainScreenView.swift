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
    func displayCurrentLocationImage(_ model: BaseImageViewModel)
}

final class MainScreenView: UIView, MainScreenViewProtocol {
    
    weak var delegate: MainScreenViewDelegate?
    
    // MARK: - UI Objects
    
    private let locationImageTopView = BaseImageView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    func displayCurrentLocationImage(_ model: BaseImageViewModel) {
        locationImageTopView.configure(with: model)
    }
}

//MARK: - Collection View Setup

private extension MainScreenView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            
            guard let sectionNumber = MainScreenSection(rawValue: sectionIndex) else { return nil }
            
            switch sectionNumber {
            case .userLocation:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(1), groupHeightSize: .absolute(70))
            case .currentWeather:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(1), groupHeightSize: .fractionalHeight(0.18), topEdgeInset: self.adaptiveTopInset)
            case .hourlyForecast:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(0.22), groupHeightSize: .fractionalHeight(0.13), headerItem: true, isGroup: true)
            case .daysForecast:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(0.3), groupHeightSize: .fractionalHeight(0.13), headerItem: true, backgroundItem: true, isGroup: true)
            case .radarForecast:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(1.0), groupHeightSize: .fractionalWidth(0.6), headerItem: true)
            case .environmentalMetrics:
                return self.createSectionUnit(groupWidthSize: .fractionalWidth(1.0), groupHeightSize: .fractionalHeight(0.18), headerItem: true, backgroundItem: true)
            }
        }
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: SectionBackgroundDecorationView.backgroundIdentifier)
        return layout
    }
    
    private func createSectionUnit(groupWidthSize: NSCollectionLayoutDimension, groupHeightSize: NSCollectionLayoutDimension, topEdgeInset: CGFloat = 16, headerItem: Bool = false, backgroundItem: Bool = false, isGroup: Bool = false) -> NSCollectionLayoutSection {
        
        let section = createBaseSection(groupWidthSize: groupWidthSize, groupHeightSize: groupHeightSize, topEdgeInset: topEdgeInset)
        if headerItem { createHeaderItem(for: section) }
        if backgroundItem { createBackgroundItem(for: section) }
        if isGroup { setupGroupSpacingAndScrolling(for: section) }
        
        return section
    }
    
    private func createBaseSection(groupWidthSize: NSCollectionLayoutDimension, groupHeightSize: NSCollectionLayoutDimension, topEdgeInset: CGFloat) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidthSize, heightDimension: groupHeightSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: topEdgeInset, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    private func createHeaderItem(for section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(30)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [headerItem]
    }
    
    private func createBackgroundItem(for section: NSCollectionLayoutSection) {
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundDecorationView.backgroundIdentifier)
        backgroundItem.contentInsets = NSDirectionalEdgeInsets(
            top: 30,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        section.decorationItems = [backgroundItem]
    }
    
    private func setupGroupSpacingAndScrolling(for section: NSCollectionLayoutSection)  {
        section.interGroupSpacing = 4
        section.orthogonalScrollingBehavior = .continuous
    }
}

// MARK: - Layout Setup

private extension MainScreenView {
    private func layoutSetup() {
        setupCollectionView()
        configureSubviews()
        makeConstrains()
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        registerCellsAndHeadersForCollectionView()
    }
    
    private func registerCellsAndHeadersForCollectionView() {
        
        collectionView.register(UserLocationViewCell.self, forCellWithReuseIdentifier: UserLocationViewCell.identifier)
        collectionView.register(CurrentWeatherViewCell.self, forCellWithReuseIdentifier: CurrentWeatherViewCell.identifier)
        collectionView.register(MainScreenHourlyWeatherSectionCell.self, forCellWithReuseIdentifier: MainScreenHourlyWeatherSectionCell.identifier)
        collectionView.register(MainScreenDaysForecastViewCell.self, forCellWithReuseIdentifier: MainScreenDaysForecastViewCell.identifier)
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        collectionView.register(MainScreenRadarViewCell.self, forCellWithReuseIdentifier: MainScreenRadarViewCell.identifier)
        collectionView.register(MainScreenEnvironmentalMetricsCell.self, forCellWithReuseIdentifier: MainScreenEnvironmentalMetricsCell.identifier)
    }
    
    private func configureSubviews() {
        addSubview(locationImageTopView)
        addSubview(collectionView)
    }
    
    private func makeConstrains() {
        locationImageTopView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImageTopView.topAnchor.constraint(equalTo: topAnchor),
            locationImageTopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationImageTopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationImageTopView.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

private extension MainScreenView {
    
    private var adaptiveTopInset: CGFloat {
        let activeScene = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }
        
        let screenHeight = activeScene?.screen.bounds.height ?? 812
        return screenHeight * 0.18
    }
    
}
