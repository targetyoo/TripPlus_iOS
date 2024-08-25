//
//  LoginResponse.swift
//  TripPlus
//
//  Created by 유대상 on 8/25/24.
//

import Foundation

struct LoginResponse: Codable {
    let name: String
    
    init(name:String) {
        self.name = name
    }
    
    //Response시 필요한 값들 추가 필요
}
