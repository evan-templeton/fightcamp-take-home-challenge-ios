//
//  ViewController.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/30/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let viewModel = PackageViewModel()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
        scrollViewSetup()
        
        scrollView.addSubview(stackView)
        stackViewSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPackages()
    }
    
    private func scrollViewSetup() {
        scrollView.backgroundColor = UIColor.secondaryBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func stackViewSetup() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = .packageSpacing
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -CGFloat.packageSpacing * 2)
        ])
    }
    
    // MARK: - Add Child View Controllers
    
    private func addPackages() {
        DispatchQueue.main.async {
            let packages = self.viewModel.fetchPackages()
            
            for package in packages {
                let packageVC: PackageViewController = {
                    
                    let packageVC = PackageViewController()
                    
                    packageVC.titleLabel.text = package.title.uppercased()
                    packageVC.descLabel.attributedText = package.desc.capitalized.setLHMultiple()
                    
                    let mainImage = UIImageView()
                    mainImage.load(url: URL(string: package.thumbnail_urls[0])!)
                    packageVC.mainImageView = mainImage
                    
                    for image in package.thumbnail_urls {
                        let imageView = UIImageView()
                        imageView.load(url: URL(string: image)!)
                        packageVC.thumbnailImages.append(imageView)
                    }
                    
                    for item in package.included { packageVC.included.append(item) }
                    
                    if let excluded = package.excluded {
                        for item in excluded { packageVC.excluded.append(item) }
                    }
                    
                    packageVC.paymentLabel.text = package.payment.capitalized
                    packageVC.priceLabel.text = "$\(package.price)"
                    packageVC.action.setTitle(package.action.capitalized, for: .normal)
                    return packageVC
                }()
                
                self.addChild(packageVC)
                self.stackView.addArrangedSubview(packageVC.view)
                packageVC.view.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).isActive = true
                packageVC.didMove(toParent: self)
            }
        }
    }
}
