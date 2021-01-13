//
//  Images.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/31/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
