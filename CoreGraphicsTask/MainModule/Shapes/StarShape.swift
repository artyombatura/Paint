//
//  StarShape.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class StarShape: AbstractShape {
    
    let numberOfEdges = 5
    let innerRadiusRatio: CGFloat = 0.5
    var outerRadius: CGFloat = 30.0
    
    private var startPoint: CGPoint!
    private var endPoint: CGPoint!
    
    override public var currentRect: CGRect {
        guard startPoint != nil, endPoint != nil else { return CGRect.zero }
        
        return CGRect(x: startPoint.x - outerRadius, y: startPoint.y - outerRadius, width: abs(endPoint.x - startPoint.x) + outerRadius, height: abs(endPoint.y - startPoint.y) + outerRadius)
    }
    
    override var rectToUpdateAfterDraw: CGRect {
        return currentRect
    }
    
    override func addPoint(point: CGPoint) {
        if startPoint == nil {
            startPoint = point
        } else {
            endPoint = point
        }
    }
    
    override func getPoints() -> [CGPoint] {
        return [startPoint ?? CGPoint.zero, endPoint ?? CGPoint.zero]
    }
    
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        guard let startPoint = points.first,
            let endPoint = points.last else { return }
        
        let rect: CGRect = CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
        outerRadius = rect.width
        
        let origin = CGPoint(x: startPoint.x, y: startPoint.y)
        let angle: CGFloat = 360.0 / CGFloat(numberOfEdges)
        let lines = (0..<(numberOfEdges * 2) + 1).map { (index) -> CGPoint in
            var point = origin
            let radius = index % 2 == 0 ? outerRadius : (outerRadius * innerRadiusRatio)
            let pointRotation = index % 2 == 0 ? CGFloat(angle * CGFloat(index)) : CGFloat(angle * CGFloat(index)) + CGFloat(angle / 2)
            
            point.y -= radius
            point = point.rotate(around: origin, with: pointRotation)
            
            return point
        }
        
        context.addLines(between: lines)
        
        context.drawPath(using: .fillStroke)
    }

}

