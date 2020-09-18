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
        
        let originX = startPoint.x >  endPoint.x ? endPoint.x : startPoint.x
        let originY = startPoint.y > endPoint.y ? endPoint.y : startPoint.y
        
        let rect: CGRect = CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
        
        let center = CGPoint(x: originX + rect.width / 2.0, y: originY + rect.height / 2.0)
        
        var angle: CGFloat = CGFloat(CGFloat.pi / 2.0)
        let angleIncrement = CGFloat(Double.pi * 2.0 / Double(numberOfEdges))
        
        let radius: CGFloat = rect.height < rect.width ? rect.height / 2.0 : rect.width / 2.0
        let midRadius: CGFloat = 0.45 * radius
                
        var firstPoint = true
        
        for _ in 1...numberOfEdges {
            let point = CGPoint.pointFrom(angle: angle, radius: midRadius, offset: center) //1
            let nextPoint = CGPoint.pointFrom(angle: angle + angleIncrement, radius: midRadius, offset: center) //2
            let midPoint = CGPoint.pointFrom(angle: angle + angleIncrement / 2.0, radius: radius, offset: center) //3
                    
            if firstPoint {
                firstPoint = false
            
                context.move(to: point)
            }
            
            context.addLine(to: midPoint)
            context.addLine(to: nextPoint)
           
            angle += angleIncrement
        }
        
        context.addLines(between: lines)
        
        context.drawPath(using: .fillStroke)
    }

}

