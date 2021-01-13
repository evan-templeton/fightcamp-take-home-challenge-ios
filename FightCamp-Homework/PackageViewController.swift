//
//  PackageViewController.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/30/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let accessoriesStackView = UIStackView()
    private let imageStackView = UIStackView()
    private let thumbnailStackView = UIStackView()
    private let priceStackView = UIStackView()
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    var mainImageView = UIImageView()
    var thumbnailImages = [UIImageView]()
    let thumbnailUrls = [String]()
    var included = [String]()
    var excluded = [String]()
    let paymentLabel = UILabel()
    let priceLabel = UILabel()
    let action = UIButton()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)
        stackView.addArrangedSubview(imageStackView)
        imageStackView.addArrangedSubview(mainImageView)
        imageStackView.addArrangedSubview(thumbnailStackView)
        stackView.addArrangedSubview(accessoriesStackView)
        stackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(paymentLabel)
        priceStackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(action)
        
        //MARK: - View
        view.backgroundColor = .primaryBackground
        view.layer.cornerRadius = .packageRadius
        
        //MARK: - stackView
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .packageSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -.packageSpacing * 2),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: .packageSpacing),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.packageSpacing)
        ])
        
        //MARK: - titleLabel
        titleLabel.textColor = .brandRed
        titleLabel.font = .title
        
        //MARK: - descLabel
        descLabel.textColor = .label
        descLabel.font = .body
        descLabel.numberOfLines = 0
        
        //MARK: - imageStackView
        imageStackView.axis = .vertical
        imageStackView.spacing = .thumbnailSpacing
        
        //MARK: - mainImageView
        mainImageView.layer.cornerRadius = .thumbnailRadius
        mainImageView.layer.masksToBounds = true
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.heightAnchor.constraint(equalToConstant: .thumbnailHeight).isActive = true
        
        //MARK: - thumbnailStackView
        thumbnailStackView.distribution = .fillEqually
        thumbnailStackView.spacing = .thumbnailSpacing
        thumbnailStackView.axis = .horizontal
        
        //MARK: - accessoriesStackView
        accessoriesStackView.distribution = .fillProportionally
        accessoriesStackView.axis = .vertical
        accessoriesStackView.spacing = .lineHeightMultiple
        
        for accessory in included {
            let label = UILabel()
            label.text = accessory.capitalized
            label.textColor = .label
            label.font = .body
            accessoriesStackView.addArrangedSubview(label)
        }
        
        for accessory in excluded {
            let label = UILabel()
            label.textColor = .disabledLabel
            label.font = .body
            label.attributedText = accessory.capitalized.strikeThrough()
            accessoriesStackView.addArrangedSubview(label)
        }
        
        //MARK: - priceStackView
        priceStackView.axis = .vertical
        priceStackView.distribution = .fillProportionally
        priceStackView.alignment = .center
        priceStackView.spacing = .thumbnailSpacing
        
        paymentLabel.textColor = .label
        paymentLabel.font = .body
        priceLabel.font = .price
        priceLabel.textColor = .label
        
        //MARK: - actionButton
        action.backgroundColor = .buttonBackground
        action.layer.cornerRadius = .buttonRadius
        action.titleLabel!.font = .button
        action.translatesAutoresizingMaskIntoConstraints = false
        action.heightAnchor.constraint(equalToConstant: .buttonHeight).isActive = true
    }
    
    // MARK: - viewDidLoad, load thumbnailImages
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in thumbnailImages {
            image.isUserInteractionEnabled = true
            let tapRec = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
            image.addGestureRecognizer(tapRec)
            
            if image == thumbnailImages[0] {
                image.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
            } else {
                image.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
            }
            image.layer.masksToBounds = true
            image.layer.borderWidth = .thumbnailBorderWidth
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = .thumbnailRadius
            
            thumbnailStackView.addArrangedSubview(image)
            
            image.translatesAutoresizingMaskIntoConstraints = false
            image.widthAnchor.constraint(equalTo: thumbnailStackView.heightAnchor).isActive = true
        }
    }
    
    // MARK: - Image Tapping Logic
    @objc public func imageTapped(sender: UITapGestureRecognizer) {
        let tappedImage = sender.view as! UIImageView
        setBorderColors(image: tappedImage)
    }
    
    func setBorderColors(image: UIImageView) {
        thumbnailImages[0].layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thumbnailImages[1].layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thumbnailImages[2].layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        thumbnailImages[3].layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
        image.layer.borderColor = UIColor.thumbnailBorder(selected: true).cgColor
        mainImageView.image = image.image
    }
}
