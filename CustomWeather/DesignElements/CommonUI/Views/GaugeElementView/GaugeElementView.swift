//
//  GaugeElementView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 11.04.2026.
//

import UIKit

final class GaugeElementView: UIView {
    
    //MARK: - UI Elements
    
    private let arcProgressView = ArcProgressView()
    
    private let topArcImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    private let topArcTitleLabel = BaseLabel()
    private let topArcValueLabel = BaseLabel()
    private let topArcSubtitleLabel = BaseLabel()
    private let statusBottomLabel = BaseLabel()
    private let descriptionBottomLabel = BaseLabel()
    
    //MARK: - UI Stacks
    
    private let arcContainer = UIView()
    
    private lazy var mainVertStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stack.spacing = 4
        return stack
    }()
    
    private lazy var topArcStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 2
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
    
    // MARK: - Public Methods
    
    func configure(with model: MainScreenMetricProtocol) {
        commonConfigure(
            title: model.title,
            progress: model.progress,
            status: model.status,
            color: model.color,
            desc: model.description)
        
        if let imageName = model.iconName {
            toggleTopArcViewMode(isIcon: true)
            configureImageNoLabels(imageName: imageName)
        }
        
        if let value = model.value, let subtitle = model.subtitle {
            toggleTopArcViewMode(isIcon: false)
            configureLabelsNoImage(value: value, subtitle: subtitle)
        }
    }
}

private extension GaugeElementView {
    
    //MARK: - Logic
    
    private func commonConfigure(title: String, progress: CGFloat, status: String, color: UIColor, desc: String) {
        
        let titleLabelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: title)
        topArcTitleLabel.configure(with: titleLabelStyle)
        
        let statusBottomLabelStyle = BaseLabelViewModel.weatherStyle(.bodyMedium, text: status)
        statusBottomLabel.configure(with: statusBottomLabelStyle)
        
        let descriptionBottomLabelStyle = BaseLabelViewModel.weatherStyle(.labelSecondary, text: desc)
        descriptionBottomLabel.configure(with: descriptionBottomLabelStyle)
        
        arcProgressView.setArc(progress: progress, color: color)
    }
    
    private func configureImageNoLabels(imageName: String) {
        topArcImageView.image = UIImage(systemName: imageName)
    }
    
    private func configureLabelsNoImage(value: String, subtitle: String) {
        
        let valueLabelStyle = BaseLabelViewModel.weatherStyle(.titleLarge, text: value)
        topArcValueLabel.configure(with: valueLabelStyle)
        
        let subtitleLabelStyle = BaseLabelViewModel.weatherStyle(.caption, text: subtitle)
        topArcSubtitleLabel.configure(with: subtitleLabelStyle)
    }
    
    private func toggleTopArcViewMode(isIcon: Bool) {
        topArcImageView.isHidden = !isIcon
        topArcSubtitleLabel.isHidden = isIcon
        topArcValueLabel.isHidden = isIcon
    }
    
    //MARK: - UI Setup
    
    private func setupLayout() {
        setupSubviews()
        makeConstrains()
    }
    
    private func setupSubviews() {
        addSubview(mainVertStack)
        [topArcSubtitleLabel, topArcValueLabel, topArcImageView, topArcTitleLabel].forEach { topArcStack.addArrangedSubview($0) }
        arcContainer.addSubview(arcProgressView)
        arcContainer.addSubview(topArcStack)
        mainVertStack.addArrangedSubview(arcContainer)
        mainVertStack.addArrangedSubview(statusBottomLabel)
        mainVertStack.addArrangedSubview(descriptionBottomLabel)
    }
    
    private func makeConstrains() {
        mainVertStack.translatesAutoresizingMaskIntoConstraints = false
        arcContainer.translatesAutoresizingMaskIntoConstraints = false
        arcProgressView.translatesAutoresizingMaskIntoConstraints = false
        topArcStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainVertStack.topAnchor.constraint(equalTo: topAnchor),
            mainVertStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainVertStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainVertStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            arcContainer.heightAnchor.constraint(equalTo: arcContainer.widthAnchor),
            
            arcProgressView.topAnchor.constraint(equalTo: arcContainer.topAnchor),
            arcProgressView.leadingAnchor.constraint(equalTo: arcContainer.leadingAnchor),
            arcProgressView.trailingAnchor.constraint(equalTo: arcContainer.trailingAnchor),
            arcProgressView.bottomAnchor.constraint(equalTo: arcContainer.bottomAnchor),
            
            topArcStack.centerXAnchor.constraint(equalTo: arcContainer.centerXAnchor),
            topArcStack.centerYAnchor.constraint(equalTo: arcContainer.centerYAnchor),
            
            topArcStack.leadingAnchor.constraint(greaterThanOrEqualTo: arcContainer.leadingAnchor, constant: 10),
            topArcStack.trailingAnchor.constraint(lessThanOrEqualTo: arcContainer.trailingAnchor, constant: -10),
            
            topArcImageView.heightAnchor.constraint(equalToConstant: 50),
            topArcImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
