//
//  ColorsPanelView.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/9/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import Foundation
import UIKit

class ColorsPanelView: UIView {
    
    // Subviews
    private var colorsPanel: UICollectionView!
    
    // Properties
    private var colors: [UIColor] = [.clear, .black, .blue, .red, .yellow, .green, .orange, .white, .gray, .purple]
    public var didSelectColor: ((UIColor) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        
        setBrushesPanel()
    }
}

// MARK: - UICollectionViewDelegate + DataSource
extension ColorsPanelView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorsPanel.dequeueReusableCell(withReuseIdentifier: ColorsCollectionViewCell.identifier, for: indexPath) as! ColorsCollectionViewCell
        let color = colors[indexPath.row]
        
        cell.config(withColor: color)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        
        didSelectColor?(color)
    }
}

//MARK: - Setup
extension ColorsPanelView {
    private func setBrushesPanel() {
        let layout = UICollectionViewFlowLayout()
        let width = self.frame.width / 4
        layout.itemSize = CGSize(width: width, height: self.frame.height)
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        colorsPanel = UICollectionView(frame: frame, collectionViewLayout: layout)
        colorsPanel.register(ColorsCollectionViewCell.self, forCellWithReuseIdentifier: ColorsCollectionViewCell.identifier)
        colorsPanel.showsVerticalScrollIndicator = false
        colorsPanel.showsHorizontalScrollIndicator =  false
        colorsPanel.backgroundColor = .white
        colorsPanel.delegate = self
        colorsPanel.dataSource = self
        self.addSubview(colorsPanel)
    }

}
