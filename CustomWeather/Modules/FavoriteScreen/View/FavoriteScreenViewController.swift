//
//  FavoriteScreenViewController.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import UIKit

protocol FavoriteScreenViewControllerInput: AnyObject {
    
}

final class FavoriteScreenViewController: UIViewController {
    
    // MARK: - Private propeties
    
    private var presenter: FavoriteScreenViewControllerOutput?
    private let mainView: FavoriteScreenViewProtocol = FavoriteScreenView()
    private let viewManager: FavoriteScreenViewManagerProtocol
    
    //MARK: - Lifecycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initialSetup()
    }
    
    // MARK: - Initialization
    
    init(viewManager: FavoriteScreenViewManagerProtocol) {
        self.viewManager = viewManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPresenter(_ presenter: FavoriteScreenViewControllerOutput) {
        self.presenter = presenter
    }
}

// MARK: - FavoriteScreenViewControllerInput

extension FavoriteScreenViewController: FavoriteScreenViewControllerInput {
    
}
