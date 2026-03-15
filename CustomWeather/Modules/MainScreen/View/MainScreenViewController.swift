//
//  MainScreenViewController.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenViewDelegate {
    
}

//MARK: - Сommands from the presenter

protocol MainScreenViewControllerInput: AnyObject {
    
}

final class MainScreenViewController: UIViewController {
    
    
    // MARK: - External dependencies
    
    private var presenter: MainScreenViewControllerOutput?
    private let contentView: MainScreenViewProtocol? = MainScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPresenter(_ presenter: MainScreenViewControllerOutput) {
        self.presenter = presenter
    }
    
}

// MARK: - MainMainScreenViewDelegate

extension MainScreenViewController: MainScreenViewDelegate {
    
}

// MARK: - MainScreenViewControllerInput

extension MainScreenViewController: MainScreenViewControllerInput {
    
}
