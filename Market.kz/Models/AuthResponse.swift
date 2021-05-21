//
//  AuthResponse.swift
//  Market.kz
//
//  Created by admin on 4/22/21.
//

import Foundation
struct AuthResponse : Codable{
    let id : Int
    let fullname : String
    let email : String
    let roles : [RoleResponse]
    let accessToken : String
    let tokenType : String
    
}

struct RoleResponse : Codable {
    let id : Int
    let role : String
}
