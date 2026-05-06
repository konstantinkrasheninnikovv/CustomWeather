
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
    
    func displayCurrentWeather(using model: CurrentWeatherModel)
    
    func displayCurrentLocationImage(_ model: BaseImageViewModel)
    func displayHourlyWeather(_ models: [MainScreenHourlyForecastWeatherModel])
    func displayDaysForecastWeather(_ models: [MainScreenDaysForecastWeatherModel])
    func displayEnvironmentalMetricsData(_ model: MainScreenEnvironmentalMetricsModel)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        presenter?.viewDidLoad()
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

    func displayCurrentLocationImage(_ model: BaseImageViewModel) {
        mainView.displayCurrentLocationImage(model)
    }
    
    func displayCurrentWeather(using model: CurrentWeatherModel) {
        viewManager.currentWeatherModel = model
        mainView.reloadInfo()
    }
    
    func displayHourlyWeather(_ models: [MainScreenHourlyForecastWeatherModel]) {
        viewManager.hourlyForecastModels = models
        mainView.reloadInfo()
    }
    
    func displayDaysForecastWeather(_ models: [MainScreenDaysForecastWeatherModel]) {
        viewManager.daysForecastModels = models
        mainView.reloadInfo()
    }
    
    func displayEnvironmentalMetricsData(_ model: MainScreenEnvironmentalMetricsModel) {
        viewManager.environmentalMetricsCell = model
        mainView.reloadInfo()
    }

}
