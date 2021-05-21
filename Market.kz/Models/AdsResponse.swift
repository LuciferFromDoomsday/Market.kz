//
//  AdsResponse.swift
//  Market.kz
//
//  Created by admin on 5/6/21.
//

import Foundation

struct AdsResponse : Codable {
//    let adType : String?
    let name : String
    let addedDate : String
    let adress : String
//    let brand : String?
    let city : String
    let description : String
    let id : Int
    let isNew : Bool
    let price : Double
//    let user : String?
}
