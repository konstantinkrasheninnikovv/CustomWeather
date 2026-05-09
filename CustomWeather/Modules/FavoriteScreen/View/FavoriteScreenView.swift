//
//  FavoriteScreenView.swift
//  CustomWeather
//
//  Created by Константин Крашенинников on 08.05.2026.
//

import UIKit

protocol FavoriteScreenViewProtocol: UIView {
    
}

final class FavoriteScreenView: UIView, FavoriteScreenViewProtocol {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        layoutSetup()
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FavoriteScreenView {
    
    
    
}
