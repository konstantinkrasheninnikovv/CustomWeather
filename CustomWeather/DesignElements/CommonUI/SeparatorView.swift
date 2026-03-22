//
//  Separator.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 21.03.2026.
//

import UIKit

final class SeparatorView: UIView {
    
    enum Orientation {
        case horizontal
        case vertical
    }
    
    private let thickness: CGFloat
    
    init(color: UIColor = .separator, thickness: CGFloat = 1.0 / UIScreen.main.scale, orientation: Orientation = .horizontal) {
        self.thickness = thickness
        super.init(frame: .zero)
        self.backgroundColor = color
        
        // Устанавливаем приоритет сжатия, чтобы линия не «раздувалась»
        if orientation == .horizontal {
            setContentHuggingPriority(.required, for: .vertical)
            setContentCompressionResistancePriority(.required, for: .vertical)
        } else {
            setContentHuggingPriority(.required, for: .horizontal)
            setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Автоматически задаем размер линии
    override var intrinsicContentSize: CGSize {
        // Если это горизонтальная линия, ширина гибкая, высота фиксированная
        return CGSize(width: UIView.noIntrinsicMetric, height: thickness)
    }
}
