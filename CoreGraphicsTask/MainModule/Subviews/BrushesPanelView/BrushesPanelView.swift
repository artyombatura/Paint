//
//  BrushesPanelView.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class BrushesPanelView: UIView {
    
    // Subviews
    private var brushesPanel: UICollectionView!
    
    // Properties
    private var brushes: [BrushType] = [.point, .line, .ellipse, .square, .star]
    public var didSelectBrush: ((BrushType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBrushesPanel()
        constraintsForBrushesPanel()
    }
}

// MARK: - UICollectionViewDelegate + DataSource
extension BrushesPanelView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brushes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brushesPanel.dequeueReusableCell(withReuseIdentifier: BrushCollectionViewCell.identifier, for: indexPath) as! BrushCollectionViewCell
        let brushType = brushes[indexPath.row]
        
        cell.config(forBrushType: brushType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let brushType = brushes[indexPath.row]
        
        didSelectBrush?(brushType)
    }
}

//MARK: - Setup
extension BrushesPanelView {
    private func setBrushesPanel() {
        let layout = UICollectionViewFlowLayout()
        let width = self.frame.width / 3
        layout.itemSize = CGSize(width: width, height: self.frame.height)
        layout.minimumInteritemSpacing = 4.0
        layout.scrollDirection = .horizontal
        
        brushesPanel = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        brushesPanel.register(BrushCollectionViewCell.self, forCellWithReuseIdentifier: BrushCollectionViewCell.identifier)
        brushesPanel.showsVerticalScrollIndicator = false
        brushesPanel.showsHorizontalScrollIndicator =  false
        brushesPanel.backgroundColor = .white
        brushesPanel.delegate = self
        brushesPanel.dataSource = self
        self.addSubview(brushesPanel)
    }
    
    private func constraintsForBrushesPanel() {
        brushesPanel.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
