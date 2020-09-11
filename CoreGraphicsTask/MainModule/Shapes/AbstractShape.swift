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
    case square = "Квадрат"
    case star = "Звезда"
}

class AbstractShape {
    public var type: BrushType!
    
    public var strokeColor: UIColor = .black
    public var fillColor: UIColor = .white
    public var lineWidth: CGFloat = 1.0
    
    private var points: [CGPoint] = []
    
    public var currentRect: CGRect {
        guard let startPoint = points.first, let endPoint = points.last else { return CGRect.zero }
        
        return CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
    }
    
    init(startPoint: CGPoint) {
        self.points.append(startPoint)
    }
    
    init(type: BrushType) {
        self.type = type
    }
    
    // Points methods
    public func removeMidPoints() -> Void {
        guard self.points.count >= 3 else { return }
        
        self.points = [self.points[0], self.points[self.points.count - 1]]
    }
    
    public func addPoint(point: CGPoint) -> Void {
        self.points.append(point)
    }
    
    public func getPoints() -> [CGPoint] {
        return self.points
    }
    
    public func getLastPoint() -> CGPoint {
        return self.points.last ?? CGPoint.zero
    }
    
    public func removeLastPoint() {
        guard self.points.count > 0 else { return }
        self.points.removeLast()
    }
    
    // Draw
    public func draw(inContext context: CGContext) {
    }
    
}
