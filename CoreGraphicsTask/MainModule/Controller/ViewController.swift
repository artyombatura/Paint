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
        
        setBrushesPanelView()
        setColorsPanelView()
        setPaintView()
        setLineWidthSlider()
        
        configTitle()
        setNavigationBar()
        configBrushesPanelView()
        configColorsPanelView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        constraintsForBrushesPanelView()
        constraintsForColorsPanelView()
        constraintsForPaintView()
        constraintsForLineWidthSlider()
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
        brushesPanelView = BrushesPanelView(frame: .zero)
        self.view.addSubview(brushesPanelView)
    }
    
    private func constraintsForBrushesPanelView() {
        brushesPanelView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.layoutMarginsGuide.snp.bottom)
            $0.height.equalTo(60.0)
        }
    }
    
    // Colors panel
    private func setColorsPanelView() {
        colorsPanelView = ColorsPanelView(frame: .zero)
        self.view.addSubview(colorsPanelView)
    }
    
    private func constraintsForColorsPanelView() {
        colorsPanelView.snp.makeConstraints {
            $0.bottom.equalTo(brushesPanelView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40.0)
        }
    }
    
    // Paint view
    private func setPaintView() {
        paintView = PaintView(frame: .zero)
        self.view.addSubview(paintView)
    }
    
    private func constraintsForPaintView() {
        paintView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(colorsPanelView.snp.top)
        }
    }
    
    // Line width slider
    private func setLineWidthSlider() {
        lineWidthSlider = UISlider(frame: .zero)
        lineWidthSlider.minimumValue = 1.0
        lineWidthSlider.maximumValue = 40.0
        
        lineWidthSlider.minimumTrackTintColor = .gray
        lineWidthSlider.maximumTrackTintColor = .lightGray
        lineWidthSlider.thumbTintColor = .white
        
        lineWidthSlider.addTarget(self, action: #selector(lineWidthAction), for: .valueChanged)
        
        self.view.addSubview(lineWidthSlider)
    }
    
    private func constraintsForLineWidthSlider() {
        lineWidthSlider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10.0)
            $0.top.equalTo(self.view.layoutMarginsGuide.snp.top).offset(20.0)
        }
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

