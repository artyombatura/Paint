//
//  Point.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class PointShape: AbstractShape {
    
    private var points: [CGPoint] = []
    
    override var currentRect: CGRect {
        guard let startPoint = points.first, let endPoint = points.last else { return CGRect.zero }
        
        return CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
    }
    
    override var rectToUpdateAfterDraw: CGRect {
        guard points.count >= 3 else { return CGRect.zero }
        let firstPoint = points[points.count - 1]
        let secondPoint = points[points.count - 2]
                
        return CGRect(x: firstPoint.x, y: firstPoint.y, width: secondPoint.x - firstPoint.x, height: secondPoint.y - firstPoint.y)
    }
    
    override func addPoint(point: CGPoint) {
        self.points.append(point)
    }
    
    override func getPoints() -> [CGPoint] {
        return self.points
    }
    
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        
        for (index, point) in points.enumerated() {
            if index == 0 { context.move(to: point) }
            else { context.addLine(to: point) }
        }
        
        context.strokePath()
    }
}
