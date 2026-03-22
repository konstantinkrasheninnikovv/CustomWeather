
//
//  MainScreenViewController.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenViewDelegate: AnyObject {
    
}

//MARK: - Сommands from the presenter

protocol MainScreenViewControllerInput: AnyObject {
    func displayHourlyWeather(_ models: [MainScreenHourlyWeatherSectionCellModel])
    func displayCurrentWeather(_ model: CurrentWeatherViewModel)
}

final class MainScreenViewController: UIViewController {
    
    // MARK: - Private propeties
    
    private var presenter: MainScreenViewControllerOutput?
    private let mainView: MainScreenViewProtocol = MainScreenView()
    private let viewManager: MainScreenViewManagerProtocol

    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    init(viewManager: MainScreenViewManagerProtocol) {
        self.viewManager = viewManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPresenter(_ presenter: MainScreenViewControllerOutput) {
        self.presenter = presenter
    }
}

// MARK: - View Controller Setup

private extension MainScreenViewController {
    
    private func initialSetup() {
        mainView.delegate = self
        setupViewManager()
    }
    
    private func setupViewManager() {
        mainView.assignManager(viewManager)
    }
}

// MARK: - MainMainScreenViewDelegate

extension MainScreenViewController: MainScreenViewDelegate {
    
}

// MARK: - MainScreenViewControllerInput

extension MainScreenViewController: MainScreenViewControllerInput {
    func displayHourlyWeather(_ models: [MainScreenHourlyWeatherSectionCellModel]) {
        viewManager.hourlyCells = models
        mainView.reloadInfo()
    }
    
    func displayCurrentWeather(_ model: CurrentWeatherViewModel) {
        mainView.displayCurrentWeather(model)
    }
}
