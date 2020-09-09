//
//  LineShape.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class LineShape: AbstractShape {
    override func draw(inContext context: CGContext) {
        let points = self.getPoints()
        guard let startPoint = points.first,
            let endPoint = points.last else { return }
        context.move(to: startPoint)
        context.addLine(to: endPoint)
    }
}
