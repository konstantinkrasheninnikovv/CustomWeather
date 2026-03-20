//
//  CoordinatorProtocol.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 14.03.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController? { get set }
    
    func startFlow()
}
