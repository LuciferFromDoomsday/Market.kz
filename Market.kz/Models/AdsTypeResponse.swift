//
//  AdsTypeResponse.swift
//  Market.kz
//
//  Created by admin on 5/6/21.
//

import Foundation

struct AllAdsTypesResponses : Codable {
   let adsTypes : [AdsTypeResponse]
}

struct AdsTypeResponse : Codable {
    
    let id : Int?

    let imageUrl: String?

    let name : String?
    
    
    
    
}
