//
//  BrushCollectionViewCell.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import UIKit

class BrushCollectionViewCell: UICollectionViewCell {
    
    // Identifier
    public static let identifier: String = "BrushCollectionViewCell"
    
    // Subviews
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
        setTitleLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        constraintsForTitleLabel()
    }

}

//MARK: - Setup
extension BrushCollectionViewCell {
    private func setTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
    }
    
    private func constraintsForTitleLabel() {
        titleLabel.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview().inset(4.0)
        }
    }
}

//MARK: - Config UI
extension BrushCollectionViewCell {
    private func configUI() {
        self.backgroundColor = .white
    }
}

//MARK: - Public methods
extension BrushCollectionViewCell {
    public func config(forBrushType type: BrushType) {
        titleLabel.text = type.rawValue
    }
}
