//
//  BaseLabel + Ext.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 13.04.2026.
//

import UIKit

extension BaseLabelViewModel {
    static func weatherStyle(_ type: FontTypography, text: String) -> BaseLabelViewModel {
        return BaseLabelViewModel(
            text: text,
            font: .systemFont(ofSize: type.fontSize, weight: type.fontWeight),
            textColor: type.textColor
        )
    }
}
