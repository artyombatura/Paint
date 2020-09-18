//
//  CGRect + Extension.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/10/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    public func extendRect(byOffset offset: CGFloat) -> CGRect {
        
        let originX: CGFloat = self.maxX > self.minX ? self.minX - offset : self.maxX - offset
        let originY: CGFloat = self.maxY > self.minY ? self.minY - offset : self.maxY - offset
        
        let newMaxX: CGFloat = self.maxX + offset
        let newMaxY: CGFloat = self.maxY + offset
        
        return CGRect(x: originX, y: originY, width: abs(newMaxX - originX), height: abs(newMaxY - originY))
        
        
    }
}
