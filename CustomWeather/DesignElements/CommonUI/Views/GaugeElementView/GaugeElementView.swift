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
    
    private lazy var topArcTitleLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.alpha = 0.6
        label.textColor = .white
        return label
    }()
    
    private lazy var topArcValueLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var topArcSubtitleLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.tintColor = .white
        label.textColor = .white
        return label
    }()
    
    private let topArcImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var statusBottomLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionBottomLabel: BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.alpha = 0.5
        return label
    }()
    
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

    func configureWithText(title: String, value: String, subtitle: String, progress: CGFloat, color: UIColor, status: String, desc: String) {
        
        toggleTopArcViewMode(isIcon: false)
        
        topArcTitleLabel.text = title
        topArcValueLabel.text = value
        topArcSubtitleLabel.text = subtitle
        commonConfigure(progress: progress, color: color, status: status, desc: desc)
    }
    
    func configureWithTextAndIcon(image: UIImage?, subtitle: String, progress: CGFloat, color: UIColor, status: String, desc: String) {
        
        toggleTopArcViewMode(isIcon: true)

        topArcSubtitleLabel.text = subtitle
        topArcImageView.image = image
        commonConfigure(progress: progress, color: color, status: status, desc: desc)
    }
}

private extension GaugeElementView {
    
    //MARK: - Logic
    
    private func commonConfigure(progress: CGFloat, color: UIColor, status: String, desc: String) {
        statusBottomLabel.text = status
        descriptionBottomLabel.text = desc
        arcProgressView.setArc(progress: progress, color: color)
    }
    
    private func toggleTopArcViewMode(isIcon: Bool) {
        topArcImageView.isHidden = !isIcon
        topArcTitleLabel.isHidden = isIcon
        topArcValueLabel.isHidden = isIcon
    }
    
    //MARK: - UI Setup
    
    private func setupLayout() {
        setupSubviews()
        makeConstrains()
    }
    
    private func setupSubviews() {
        addSubview(mainVertStack)
        [topArcTitleLabel, topArcValueLabel, topArcImageView, topArcSubtitleLabel].forEach { topArcStack.addArrangedSubview($0) }
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
            topArcStack.trailingAnchor.constraint(lessThanOrEqualTo: arcContainer.trailingAnchor, constant: -10)
        ])
    }
}
