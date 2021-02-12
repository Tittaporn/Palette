//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Lee McCormick on 2/9/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    // MARK: - Life Cycle Methods
    override func loadView() { //loadView() ==> Come first before viewDidLoad()
        super.loadView()
        // The order here is important because each constrain related to each other. TOP DOWN FROM THE VIEW.
        addAllSubViews()
        setupButtonStackView()
        constrainTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        configureTableView()
        activateButtons()
        UnsplashService.shared.fetchFromUnsplash(for: .featured) { (photos) in
            DispatchQueue.main.async {
                guard let photos = photos else { return }
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    // MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var photos: [UnsplashPhoto] = []
    var buttons: [UIButton] {
        return [featuredButton,randomButton,doubleRainbowButton]
    }
    
    // MARK: - Methods
    func addAllSubViews() {
        // Add
        // The view add subview
        self.view.addSubview(featuredButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setupButtonStackView() {
        // The stackView add Button
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        
        //Constraints
        // Anchor is important.
        buttonStackView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 16).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 8).isActive = true
        // Always negative for trailingAnchor to stay in the view ex. -8
        buttonStackView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor,constant: -8).isActive = true
    }
    
    func constrainTableView() {
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        // Create Cell Class and reuseIdentifier
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "photoCell")
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach { $0.setTitleColor(.lightGray, for: .normal)}
        sender.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
        
        switch sender {
        case featuredButton:
            searchForCategory(.featured)
        case randomButton:
            searchForCategory(.random)
        case doubleRainbowButton:
            searchForCategory(.doubleRainbow)
        default:
            searchForCategory(.featured)
        }
    }
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)}
        featuredButton.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
       
    }

    func searchForCategory(_ unsplashRoute: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (upsplashPhotos) in
            DispatchQueue.main.async {
                guard let upsplashPhotos = upsplashPhotos else { return }
                self.photos = upsplashPhotos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    // MARK: - Views ==> Create
    // Here is the formate for creating something.
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Double Rainbow", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    // Create a stackView for button
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false // if you leave it true, the xCode Try to help you constraints
        return stackView
    }()
    
    let paletteTableView : UITableView = {
    let tableView = UITableView()
    return tableView
    }()
    
} //End of class

// MARK: - Extensions
extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PaletteTableViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // We count the hight by label and image on the cell
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        
        let labelSpace: CGFloat = SpacingConstants.smallElementHeight
        //let objectBuffer: CGFloat =  SpacingConstants.verticalObjectBuffer
        let objectBuffer =  SpacingConstants.verticalObjectBuffer
        
        let colorpalatteViewSpace = SpacingConstants.mediumElementHeight
        let secondObjectBuffer = SpacingConstants.verticalObjectBuffer
        
        return imageViewSpace + outerVerticalPadding + labelSpace + objectBuffer + colorpalatteViewSpace + secondObjectBuffer
    }
}





/* NOTE
 3 STEPS OF PROGRAMATICCONSTRAINTS
  1) CREATE
  2) ADD
  3) CONSTRAINTS
 //______________________________________________________________________________________
 */


