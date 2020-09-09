//
//  ShapeFactoryMethod.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation


class ShapeFactory {
    public static func factoryMethod(type: BrushType) -> AbstractShape {
        switch type {
        case .point:     return PointShape(type: .point)
        case .line:      return LineShape(type: .line)
        case .ellipse:   return EllipseShape(type: .ellipse)
        case .square:    return SquareShape(type: .square)
        case .star:      return StarShape(type: .star)
        }
    }
}
