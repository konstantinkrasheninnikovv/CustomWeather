//
//  BaseLabel.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 19.03.2026.
//

import UIKit

protocol BaseLabelViewModelProtocol {
    var text: String? { get set }
    var font: UIFont? { get set }
    var textColor: UIColor? { get set }
    var textAligment: NSTextAlignment? { get set }
    var numberOfLines: Int? { get set }
    var textSpacing: CGFloat? { get set }
    var backgroundColor: UIColor? { get set }
}

struct BaseLabelViewModel: BaseLabelViewModelProtocol {
    var text: String?
    var font: UIFont? = .systemFont(ofSize: 14)
    var textColor: UIColor? = .white
    var textAligment: NSTextAlignment? = .left
    var numberOfLines: Int? = 0
    var textSpacing: CGFloat? = 0
    var backgroundColor: UIColor? = .clear
}

protocol BaseLabelProtocol {
    func configure(with model: BaseLabelViewModelProtocol)
}

final class BaseLabel: UILabel, BaseLabelProtocol {
    
    func configure(with model: BaseLabelViewModelProtocol) {
        self.text = model.text
        self.font = model.font
        self.textColor = model.textColor
        if let numberOfLines = model.numberOfLines {
            self.numberOfLines = numberOfLines
        }
        if let textAligment = model.textAligment {
            self.textAlignment = textAligment
        }
        if let spacing = model.textSpacing, let text = model.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        } else {
            self.text = model.text
        }
        if let backgroundColor = model.backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}
