//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Lee McCormick on 2/9/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {
    
    // MARK: - Life Cycle Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
    }
    
    // MARK: - Properties
    var colors: [UIColor]? {
        didSet {
            buildColorBricks()
        }
    }
    
    // MARK: - Helper Fuctions
    func  buildColorBricks() {
        resetColorBricks()
        guard let colors = colors else { return }
        for color in colors {
            let colorBrick = generateColorBricks(for: color)
            self.addSubview(colorBrick)
            self.colorStackView.addArrangedSubview(colorBrick)
        }
        self.layoutIfNeeded() //==> If we change stackView, need to refresh it.
    }
    
    func generateColorBricks(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    func resetColorBricks() {
        for subview in colorStackView.arrangedSubviews {
            self.colorStackView.removeArrangedSubview(subview)
        }
    }
    
    func setupViews() {
        self.addSubview(colorStackView)
        colorStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        self.layer.cornerRadius = (self.frame.height / 2)
        self.layer.masksToBounds = true
    }
    
    // MARK: - Views
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
}
