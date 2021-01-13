//
//  PackageAPI.swift
//  FightCamp-Homework
//
//  Created by Evan Templeton on 12/30/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

struct PackageAPI {
    func fetchPackages() -> [Package] {
        
        var packagesArray = [Package]()
        if let path = Bundle.main.path(forResource: "packages", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let packages = self.parseJSON(data) { packagesArray = packages }
            } catch {
                print("JSON Retreival Error \(error)")
            }
        }
        return packagesArray
    }
    
    func parseJSON(_ data: Data) -> [Package]? {
        let decoder = JSONDecoder()
        var packages = [Package]()
        do {
            let data = try decoder.decode(Array<PackageData>.self, from: data)
            for item in data {
                let title = item.title
                let desc = item.desc
                
                let thumbnail_urls: [String] = {
                    var urls = [String]()
                    for url in item.thumbnail_urls { urls.append(url) }
                    return urls
                }()
                
                let included: [String] = {
                    var included = [String]()
                    for item in item.included { included.append(item) }
                    return included
                }()
                
                let excluded: [String]? = {
                    var excluded = [String]()
                    if item.excluded != nil {
                        for item in item.excluded! {
                            excluded.append(item)
                        }
                        return excluded
                    } else { return nil }
                }()
                
                let payment = item.payment
                let price = item.price
                let action = item.action
                let package = Package(title: title,
                                      desc: desc,
                                      thumbnail_urls: thumbnail_urls,
                                      included: included,
                                      excluded: excluded,
                                      payment: payment,
                                      price: price,
                                      action: action)
                packages.append(package)
            }
        } catch {
            print("JSON Parsing Error \(error)")
            return nil
        }
        return packages
    }
}
