//
//  DateFormatter + Ext.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 06.05.2026.
//

import Foundation

extension DateFormatter {
    static let dayOfWeek: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
}
