//
//  EllipseShape.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class EllipseShape: AbstractShape {
    
    private var startPoint: CGPoint!
    private var endPoint: CGPoint!
    
    override var currentRect: CGRect {
        guard startPoint != nil, endPoint != nil else { return CGRect.zero }
        
        return CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
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
        
        context.addEllipse(in: rect)
        
        context.drawPath(using: .fillStroke)
    }
}
