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
        return CGRect.zero
    }
    
    public func extendRect(scale: CGFloat) -> CGRect {
        
        let newHeight: CGFloat = self.height * scale
        let newWidth: CGFloat = self.width * scale
        
        let newOriginX = self.minX - (newWidth / 2) + (self.width / 2)
        let newOriginY = self.minY - (newHeight / 2) + (self.height / 2)
        
        return CGRect(x: newOriginX, y: newOriginY, width: newWidth, height: newHeight)
    }
}
