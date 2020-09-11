//
//  PaintView.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/8/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import UIKit

protocol PaintViewInterface {
    var currentBrush: BrushType { get set }
    
    func clearContext()
    func undoContext()
}

class PaintView: UIView {

    //MARK: - PROPERTIES
    private var shapes: [AbstractShape] = []
    var currentBrush: BrushType = .point
    var currentStrokeColor: UIColor = .black
    var currentFillColor: UIColor = .clear
    var currentLineWidth: CGFloat = 3.0
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.autoresizesSubviews = true
        self.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        
        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        shapes.forEach { (shape) in
            if rect.contains(shape.currentRect) {
                guard let context = UIGraphicsGetCurrentContext() else { return }
                context.setLineWidth(shape.lineWidth)
                context.setLineCap(.round)

                context.setStrokeColor(shape.strokeColor.cgColor)
                context.setFillColor(shape.fillColor.cgColor)

                shape.draw(inContext: context)
            }
        }
    }

}

//MARK: - PaintViewInterface Implementation
extension PaintView: PaintViewInterface {
    func clearContext() {
        shapes = [AbstractShape]()
        setNeedsDisplay()
    }
    
    func undoContext() {
        guard !shapes.isEmpty else { return }
        shapes = shapes.dropLast()
        setNeedsDisplay()
    }
}

// UIResponder override
extension PaintView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
    
        let newShape = ShapeFactory.factoryMethod(type: self.currentBrush)
        newShape.addPoint(point: location)
        
        newShape.strokeColor = currentStrokeColor
        newShape.fillColor = currentFillColor
        newShape.lineWidth = currentLineWidth
        
        self.shapes.append(newShape)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let currentShape = shapes.popLast() else { return }
        let location = touch.location(in: self)

        let previousRect = currentShape.rectToUpdateAfterDraw.extendRect(byOffset: currentLineWidth)
        
        currentShape.addPoint(point: location)
        shapes.append(currentShape)
        
        setNeedsDisplay(previousRect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let currentShape = shapes.popLast() else { return }
        let location = touch.location(in: self)
        
        currentShape.addPoint(point: location)
        shapes.append(currentShape)
        
        let shapeRect: CGRect = currentShape.rectToUpdateAfterDraw.extendRect(byOffset: currentLineWidth)
        setNeedsDisplay(shapeRect)
    }
}
