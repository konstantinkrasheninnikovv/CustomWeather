//
//  GaugeElementView.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 11.04.2026.
//

import UIKit

final class ArcProgressView: UIView {
    
    //MARK: - Constants
    
    private enum Angles {
        static let start = CGFloat.pi * 0.75
        static let end = CGFloat.pi * 0.25
    }
    
    //MARK: - UI Elements
    
    /// Слой-"подложка": статичная серая дуга на заднем плане.
    private let trackLayer = CAShapeLayer()
    /// Активный слой прогресса: цветная дуга, которая меняет длину.
    private let progressLayer = CAShapeLayer()
    
    var lineWidth: CGFloat = 12.0 {
        didSet {
//            trackLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
            updatePaths()
        }
    }
    
    /// Цвет фона дуги ("подложки").
    var trackColor: UIColor = UIColor.white.withAlphaComponent(0.1) {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    //MARK: - UI Stacks
    
    private lazy var mainVertStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        stack.spacing = 8
        return stack
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
    }
    
    // MARK: - Публичные методы (Управление прогрессом)
    
    /// Основной метод для установки значений. Устанавливает прогресс, цвет и эффект свечения.
    /// - Parameters:
    ///   - progress: Значение от 0.0 до 1.0.
    ///   - color: Цвет активной дуги.
    ///   - animated: Флаг для плавного изменения длины дуги.
    ///   - glow: Флаг для добавления эффекта "неона" вокруг дуги.
    func setArc(progress: CGFloat, color: UIColor, animated: Bool = true, glow: Bool = true) {
        // Валидируем прогресс, чтобы он был в диапазоне [0, 1]
        let clampedProgress = max(0.0, min(1.0, progress))
        
        // Устанавливаем цвет и свечение
        progressLayer.strokeColor = color.cgColor
        if glow {
            applyGlow(with: color)
        } else {
            removeGlow()
        }
        
        // Обновляем прогресс
        if animated {
            animateProgress(to: clampedProgress)
        } else {
            // Без анимации просто устанавливаем конечное значение
            CATransaction.begin()
            CATransaction.setDisableActions(true) // Отключаем стандартные неявные анимации CAShapeLayer
            progressLayer.strokeEnd = clampedProgress
            CATransaction.commit()
        }
    }
}

private extension ArcProgressView {
    
    /// Начальная настройка слоев при инициализации.
    func setupLayers() {
        backgroundColor = .clear // Фон самой вьюхи должен быть прозрачным
        
        // Настраиваем общие свойства для обоих слоев
        [trackLayer, progressLayer].forEach { (layer: CAShapeLayer) in
            layer.fillColor = nil // Внутренность круга не заливаем
            layer.lineCap = .round // Закругленные края дуги (как на макете)
            layer.lineWidth = lineWidth
            // Добавляем слои в иерархию (сначала подложку, потом прогресс)
            self.layer.addSublayer(layer)
        }
        
        // Устанавливаем начальные цвета и состояние
        trackLayer.strokeColor = trackColor.cgColor
        progressLayer.strokeEnd = 0.0 // Изначально дуга пустая
    }
    
    /// Создает и обновляет пути (UIBezierPath) для рисования дуги на основе текущих bounds.
    func updatePaths() {
        // Вычисляем геометрию
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let diameter = min(bounds.width, bounds.height)
        // Радиус должен учитывать толщину линии, чтобы дуга не "вылезала" за границы.
        let radius = diameter / 2.0 - lineWidth / 2.0
        
        // Создаем путь дуги по часовой стрелке через верх
        let arcPath = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: Angles.start,
                                   endAngle: Angles.end,
                                   clockwise: true)
        
        // Применяем созданный путь к слоям
        CATransaction.begin()
        CATransaction.setDisableActions(true) // Отключаем анимацию при изменении пути
        trackLayer.path = arcPath.cgPath
        progressLayer.path = arcPath.cgPath
        CATransaction.commit()
    }
    
    /// Создает плавную анимацию изменения свойства strokeEnd.
    func animateProgress(to progress: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressLayer.strokeEnd // Анимируем от текущего визуального состояния
        animation.toValue = progress
        animation.duration = 1.0 // Продолжительность анимации
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // Плавное начало и конец
        
        // Устанавливаем конечное значение до добавления анимации, чтобы оно сохранилось по завершении
        progressLayer.strokeEnd = progress
        progressLayer.add(animation, forKey: "animateProgress")
    }
    
    // MARK: - Эффекты (CAShapeLayer Shadows)
    
    /// Добавляет эффект свечения (Shadow), накладываемый на активную дугу.
    func applyGlow(with color: UIColor) {
        progressLayer.shadowColor = color.cgColor
        progressLayer.shadowRadius = 12.0 // Толщина свечения
        progressLayer.shadowOpacity = 0.8 // Интенсивность
        progressLayer.shadowOffset = .zero // Свечение равномерно вокруг линии
    }
    
    func removeGlow() {
        progressLayer.shadowColor = nil
        progressLayer.shadowRadius = 0
        progressLayer.shadowOpacity = 0
    }
}
