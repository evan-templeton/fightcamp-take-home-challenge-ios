//
//  MainViewModel.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/31/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

public class PackageViewModel {
    private let packageApi = PackageAPI()
    
    func fetchPackages() -> [Package] {
        let packages = packageApi.fetchPackages()
        return packages
    }
}


