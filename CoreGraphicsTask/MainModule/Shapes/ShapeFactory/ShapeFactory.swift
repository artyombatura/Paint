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
        case .point:     return PointShape()
        case .line:      return LineShape()
        case .ellipse:   return EllipseShape()
        case .rectangle:    return RectangleShape()
        case .star:      return StarShape()
        }
    }
}
