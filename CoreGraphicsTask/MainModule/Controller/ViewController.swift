//
//  ViewController.swift
//  CoreGraphicsTask
//
//  Created by Artsiom Batura on 9/8/20.
//  Copyright © 2020 Artsiom Batura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Subviews
    private var paintView: PaintView!
    private var brushesPanelView: BrushesPanelView!
    private var colorsPanelView: ColorsPanelView!
    private var lineWidthSlider: UISlider!
    
    private var colorPickingModesButton: UIBarButtonItem!
    
    //MARK: - Properties
    private var isStrokeColorSelecting: Bool = true {
        didSet {
            colorPickingModesButton.title = self.isStrokeColorSelecting ? "Stroke" : "Fill"
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPaintView()
        setBrushesPanelView()
        setColorsPanelView()
        setLineWidthSlider()
        
        configTitle()
        setNavigationBar()
        configBrushesPanelView()
        configColorsPanelView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.autoresizesSubviews = true
        self.view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
    }
    
    //MARK: - Actions
    @objc private func clearFieldAction() {
        paintView.clearContext()
    }
    
    @objc private func undoAction() {
        paintView.undoContext()
    }
    
    @objc private func changeColorPickingMode() {
        self.isStrokeColorSelecting = !self.isStrokeColorSelecting
    }
    
    @objc private func lineWidthAction() {
        paintView.currentLineWidth = CGFloat(Int(lineWidthSlider.value))
    }
}

//MARK: - Setup
extension ViewController {
    // Brushes panel
    private func setBrushesPanelView() {
        let expectedHeight: CGFloat = 60.0
        let bottomSafeAreaHeight: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        let frame: CGRect = CGRect(x: self.view.frame.origin.x, y: self.view.frame.height - bottomSafeAreaHeight - expectedHeight, width: self.view.frame.width, height: expectedHeight)
        
        brushesPanelView = BrushesPanelView(frame: frame)
        self.view.addSubview(brushesPanelView)
    }
    
    // Colors panel
    private func setColorsPanelView() {
        let expectedHeight: CGFloat = 40.0
        let frame: CGRect = CGRect(x: self.view.frame.origin.x, y: self.brushesPanelView.frame.origin.y - expectedHeight, width: self.view.frame.width, height: expectedHeight)
        
        colorsPanelView = ColorsPanelView(frame: frame)
        self.view.addSubview(colorsPanelView)
    }
    
    // Paint view
    private func setPaintView() {
        paintView = PaintView(frame: self.view.frame)
        self.view.addSubview(paintView)
    }
    
    // Line width slider
    private func setLineWidthSlider() {
        let expectedHeight: CGFloat = 20.0
        let navBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
        let frame: CGRect = CGRect(x: self.view.frame.origin.x, y: 10.0 + navBarHeight, width: self.view.frame.width, height: expectedHeight)
        
        lineWidthSlider = UISlider(frame: frame)
        lineWidthSlider.minimumValue = Float(paintView.currentLineWidth)
        lineWidthSlider.maximumValue = 40.0
        
        lineWidthSlider.minimumTrackTintColor = .gray
        lineWidthSlider.maximumTrackTintColor = .lightGray
        lineWidthSlider.thumbTintColor = .white
        
        lineWidthSlider.addTarget(self, action: #selector(lineWidthAction), for: .valueChanged)
        
        self.view.addSubview(lineWidthSlider)
    }

}

// Config brushes panelView
extension ViewController {
    private func configBrushesPanelView() {
        brushesPanelView.didSelectBrush = { [weak self] (brushType) in
            self?.paintView.currentBrush = brushType
            self?.configTitle()
        }
    }
    
    private func configColorsPanelView() {
        colorsPanelView.didSelectColor = { [weak self] (color) in
            guard let self = self else { return }
            if self.isStrokeColorSelecting {
                self.paintView.currentStrokeColor = color
            } else {
                self.paintView.currentFillColor = color
            }
        }
    }
}

// Config UI
extension ViewController {
    private func configTitle() {
        self.title = paintView.currentBrush.rawValue
    }
}

extension ViewController {
    private func setNavigationBar() {
        let clearFieldButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(clearFieldAction))
        colorPickingModesButton = UIBarButtonItem(title: "Stroke", style: .done, target: self, action: #selector(changeColorPickingMode))
        
        self.navigationItem.rightBarButtonItems = [clearFieldButton, colorPickingModesButton]
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Undo", style: .done, target: self, action: #selector(undoAction))
    }
}

