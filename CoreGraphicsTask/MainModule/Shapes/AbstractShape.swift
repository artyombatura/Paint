//
//  AbstractShape.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

enum BrushType: String {
    case point = "Точка"
    case line = "Линия"
    case ellipse = "Эллипс"
    case rectangle = "Прямоугольник"
    case star = "Звезда"
}

class AbstractShape {    
    public var strokeColor: UIColor = .black
    public var fillColor: UIColor = .white
    public var lineWidth: CGFloat = 1.0
    
    public var currentRect: CGRect {
        return CGRect.zero
    }
    
    public var rectToUpdateAfterDraw: CGRect {
        return CGRect.zero
    }
    
    init() {}
    
    // Points methods
    public func addPoint(point: CGPoint) -> Void {
    }
    
    public func getPoints() -> [CGPoint] {
        return [CGPoint]()
    }
    
    // Draw
    public func draw(inContext context: CGContext) {
    }
    
}
