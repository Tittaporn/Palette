//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Lee McCormick on 2/9/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    // MARK: - Life Cycle Methods
    override func layoutSubviews() { //UITableViewCell Don't have viewDidLoad, So USE `layoutSubviews()` HERE!!
        super.layoutSubviews()
        addAllSubviews()
        constrainImageView()
        constrainTitleLabel()
        constrainConlorPaletteView()
    }
    
    // MARK: - Properties
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    
    
    // MARK: - Methods
    func updateViews() {
        guard let photo = photo else { return }
        // Fetch image
        fetchAllSetImage(for: photo)
        // Fetch colors for image
        fetchAndSetColorStack(for: photo)
        paletteTitleLabel.text = photo.description ?? "Tenet"
    }
    
    func fetchAllSetImage(for upsplashPhoto: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: upsplashPhoto) { (image) in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }

    func fetchAndSetColorStack(for upsplashPhoto: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: upsplashPhoto.urls.regular) { (colors) in
            
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
            
        }
    }
    
    func addAllSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func constrainImageView() {
        let imageViewWidth = self.contentView.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        paletteImageView.anchor(top: self.contentView.topAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.outerVerticalPadding, paddingBottom: 0, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: imageViewWidth, height: imageViewWidth)
    }
    
    func constrainTitleLabel() {
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: 0, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.smallElementHeight)
    }
    
    func constrainConlorPaletteView() {
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.outerVerticalPadding, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.mediumElementHeight)
    }
    
    // MARK: - Views
    // Create Those Views for outlets
    let paletteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    let paletteTitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Florida Man"
        return label
    }()
    
    let colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
}

/* NOTE
 
     // For Testing in updateViews()
     // colorPaletteView.colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
 //______________________________________________________________________________________
 */
