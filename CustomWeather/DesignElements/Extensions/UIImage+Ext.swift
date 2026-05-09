//
//  UIImage+Ext.swift
//  CustomWeather
//
//  Created by Konstantin Krasheninnikov on 08.05.2026.
//

import UIKit

extension UIImage {
    func getBottomAverageColor() -> UIColor? {
        let scanHeight = size.height * 0.05
        let scanRect = CGRect(x: 0,
                              y: size.height - scanHeight,
                              width: size.width,
                              height: scanHeight)
        
        guard let cgImage = self.cgImage?.cropping(to: scanRect) else { return nil }
        let bottomStrip = UIImage(cgImage: cgImage)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1), format: format)
        
        let averageColorImage = renderer.image { _ in
            bottomStrip.draw(in: CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        
        return averageColorImage.firstPixelColor()
    }
    
    private func firstPixelColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = 1
        let height = 1
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        var rawData = [UInt8](repeating: 0, count: bytesPerPixel)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        guard let context = CGContext(data: &rawData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo) else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return UIColor(
            red:   CGFloat(rawData[0]) / 255.0,
            green: CGFloat(rawData[1]) / 255.0,
            blue:  CGFloat(rawData[2]) / 255.0,
            alpha: CGFloat(rawData[3]) / 255.0
        )
    }
}
