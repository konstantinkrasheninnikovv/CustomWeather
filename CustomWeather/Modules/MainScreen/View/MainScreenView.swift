//
//  MainScreenView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol MainScreenViewProtocol: UIView {
    var delegate: MainScreenViewDelegate? { get set }
}

final class MainScreenView: UIView, MainScreenViewProtocol {
    
    var delegate: MainScreenViewDelegate?
    
}
