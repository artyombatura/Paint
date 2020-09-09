//
//  SquareShape.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class SquareShape: AbstractShape {
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        guard let startPoint = points.first,
            let endPoint = points.last else { return }

        let height = endPoint.y - startPoint.y
        let width = height

        let rect: CGRect = CGRect(x: startPoint.x, y: startPoint.y, width: width, height: height)
        
        context.addRect(rect)
    }
}
