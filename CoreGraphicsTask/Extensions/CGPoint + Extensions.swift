//
//  CGPoint + Extensions.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func rotate(around center: CGPoint, with degrees: CGFloat) -> CGPoint {
        let dx = self.x - center.x
        let dy = self.y - center.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * CGFloat(M_PI / 180.0) // convert it to radians
        let x = center.x + radius * cos(newAzimuth)
        let y = center.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}

// Static
extension CGPoint {
    static func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
       let x = radius * cos(angle) + offset.x
       let y = radius * sin(angle) + offset.y
            
       return CGPoint(x: x, y: y)
    }
}
