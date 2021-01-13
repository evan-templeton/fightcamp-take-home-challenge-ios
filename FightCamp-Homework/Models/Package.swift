//
//  Package.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/30/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

struct Package {
    let title: String
    let desc: String
    let thumbnail_urls: [String]
    let included: [String]
    let excluded: [String]?
    let payment: String
    let price: Int
    let action: String
}
