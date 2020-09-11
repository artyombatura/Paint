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
    
    
    
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        guard let startPoint = points.first,
            let endPoint = points.last else { return }
        let rect: CGRect = CGRect(x: startPoint.x, y: startPoint.y, width: endPoint.x - startPoint.x, height: endPoint.y - startPoint.y)
        
        context.addEllipse(in: rect)
    }
}
