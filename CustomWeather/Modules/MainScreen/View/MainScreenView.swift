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
    
    private lazy var locationImageTopView: BaseImageView = {
        let view = BaseImageView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(CurrentWeatherViewCell.self, forCellWithReuseIdentifier: CurrentWeatherViewCell.identifier)
        cv.register(MainScreenHourlyWeatherSectionCell.self, forCellWithReuseIdentifier: MainScreenHourlyWeatherSectionCell.identifier)
        cv.register(MainScreenDaysForecastViewCell.self, forCellWithReuseIdentifier: MainScreenDaysForecastViewCell.identifier)
        cv.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        cv.register(MainScreenRadarViewCell.self, forCellWithReuseIdentifier: MainScreenRadarViewCell.identifier)
        cv.register(AirQualitySectionCell.self, forCellWithReuseIdentifier: AirQualitySectionCell.identifier)
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
            
            switch sectionIndex {
            case 0:
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 160, leading: 0, bottom: 20, trailing: 0)
                
                return section
                
            case 1:
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(30)
                )
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                headerItem.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 10, trailing: 16)
                section.interGroupSpacing = 6
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case 2:
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(60),
                    heightDimension: .absolute(115))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 10, trailing: 16)
                
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
                
                let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "SectionBackground")
                backgroundItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 30,
                    leading: 10,
                    bottom: 10,
                    trailing: 10
                )
                
                section.decorationItems = [backgroundItem]
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                section.interGroupSpacing = 2
                section.orthogonalScrollingBehavior = .continuous
                
                return section
                
            case 3:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                headerItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: -10, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
                
            case 4:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 10, trailing: 16)


                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(30)
                )
                
                let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "SectionBackground")
                backgroundItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 30,
                    leading: 10,
                    bottom: 10,
                    trailing: 10
                )
                section.decorationItems = [backgroundItem]

                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                headerItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: -10, trailing: 0)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
                
            default:
                return nil

            }
        }
        layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: "SectionBackground")
        return layout
    }
}

// MARK: - Layout

private extension MainScreenView {
    private func layoutSetup() {
        configureSubviews()
        makeConstrains()
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
