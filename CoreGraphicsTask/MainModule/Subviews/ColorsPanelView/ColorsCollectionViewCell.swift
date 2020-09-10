//
//  ColorsCollectionViewCell.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {
    
    // Identifier
    public static let identifier: String = "ColorsCollectionViewCell"
    
    // INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configLayer()
    }
}

//MARK: - Config layer
extension ColorsCollectionViewCell {
    private func configLayer() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
    }
}

// Public methods
extension ColorsCollectionViewCell {
    public func config(withColor color: UIColor) {
        self.backgroundColor = color
    }
}
