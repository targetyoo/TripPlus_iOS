//
//  MakingLocationViewModel.swift
//  TripPlus
//
//  Created by andev on 6/2/25.
//

import Foundation
import Combine

class MakingLocationViewModel{
    @Published var locationItems: [String : String] = [
        "강릉" : "대한민국, 강원도",
        "부산광역시" : "대한민국, 경상도",
        "도쿄" : "일본, 도쿄도",
        "오사카" : "일본, 오사카부",
        "제주도" : "대한민국, 제주특별자치도"
    ] //Temp data
    
    @Published var selectedLocationItems: [String] = []
    
    var locationItemKeys: [String] {
           return Array(locationItems.keys) // Dictionary의 키를 배열로 변환
    }
    
    func addSelectedLocationElement(element: String) {
        addLocationSubject.send()
        if !selectedLocationItems.contains(element){
            selectedLocationItems.append(element)
        }
    }
    
    func removeSelectedLocationElement(element: String) {
        if let index = selectedLocationItems.firstIndex(of: element) {
            selectedLocationItems.remove(at: index)
        }
    }
    
    private let addLocationSubject = PassthroughSubject<Void, Never>()

    

}
