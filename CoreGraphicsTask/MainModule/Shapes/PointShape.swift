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
    
    
    
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        
        for (index, point) in points.enumerated() {
            if index == 0 { context.move(to: point) }
            else { context.addLine(to: point) }
        }
    }
}
