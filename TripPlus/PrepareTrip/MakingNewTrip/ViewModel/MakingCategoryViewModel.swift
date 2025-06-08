//
//  MakingCategoryViewModel.swift
//  TripPlus
//
//  Created by andev on 6/2/25.
//

import Foundation
import Combine

class MakingCategoryViewModel{
    
    @Published var selectedCategoryItems: [String] = []

    
    @Published var categoryItems: [String] = ["배낭 여행", "신혼 여행", "드라이브", "등산", "관광", "크루즈", "해외 여행", "국내 여행", "뚜벅이 여행", "출장", "호캉스"] //temp data
    
    func addSelectedCategoryElement(element: String) {
        addCategorySubject.send()
        if !selectedCategoryItems.contains(element){
            selectedCategoryItems.append(element)
        }
    }
    
    func removeSelectedCategoryElement(element: String) {
        if selectedCategoryItems.contains(element){
            if let index = selectedCategoryItems.firstIndex(of: element) {
                selectedCategoryItems.remove(at: index)
            }
        }
    }
    
    private let addCategorySubject = PassthroughSubject<Void, Never>()

}
