//
//  UIImage.swift
//  Restaurant
//
//  Created by olivier geiger on 01/04/2024.
//

import UIKit

extension UIImage {
    
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func withRoundedCorners(radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func aspectFilled(to newSize: CGSize) -> UIImage? {
        let newSizeRatio = newSize.width / newSize.height
        let currentSizeRatio = size.width / size.height
        
        var rect = CGRect.zero
        if newSizeRatio > currentSizeRatio {
            rect.size.width = newSize.width
            rect.size.height = newSize.width / currentSizeRatio
            rect.origin.y = (newSize.height - rect.size.height) / 2
        } else {
            rect.size.height = newSize.height
            rect.size.width = newSize.height * currentSizeRatio
            rect.origin.x = (newSize.width - rect.size.width) / 2
        }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
        
    }
}
