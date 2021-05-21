//
//  Ads.swift
//  Market.kz
//
//  Created by admin on 5/5/21.
//

import Foundation
import UIKit
struct Ads {
    internal init(name: String, price: String, images: [UIImage], city: String, address: String, wasInUse: Bool, description: String, category: AdsTypeResponse) {
        self.name = name
        self.price = price
        self.images = images
        self.city = city
        self.address = address
        self.wasInUse = wasInUse
        self.description = description
        self.category = category
    }
    
    
    let name : String
    let price : String
    let images : [UIImage]
    let city : String
    let address : String
    let wasInUse : Bool
    let description : String
    let category : AdsTypeResponse
    
    
}
