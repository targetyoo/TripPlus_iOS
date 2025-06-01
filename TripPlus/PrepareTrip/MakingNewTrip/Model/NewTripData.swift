//
//  NewTripData.swift
//  TripPlus
//
//  Created by 유대상 on 6/2/25.
//

import Foundation

struct NewTripData{
    var name: String
    var type: String = "보통"
    var departTime: String
    var arriveTime: String
    var category: [String]
    var location: [String]
    
    var packages : [NewPackage]
}
