//
//  MakingNewTripModel.swift
//  TripPlus
//
//  Created by 유대상 on 1/8/25.
//

import Foundation
import Combine

class MakingNewTripModel {
        
    @Published var tripName = ""
    
    @Published var packagePrepareType = "보통"

//    @Published var departDate: Date = Date()
//    @Published var arriveDate: Date = Date() + 1
    
//    @Published var selectedCategoryItems: [String] = []
//    @Published var selectedLocationItems: [String] = []
    

//    @Published var categoryItems: [String] = ["배낭 여행", "신혼 여행", "드라이브", "등산", "관광", "크루즈", "해외 여행", "국내 여행", "뚜벅이 여행", "출장", "호캉스"] //temp data
    
//    @Published var locationItems: [String : String] = [
//        "강릉" : "대한민국, 강원도",
//        "부산광역시" : "대한민국, 경상도",
//        "도쿄" : "일본, 도쿄도",
//        "오사카" : "일본, 오사카부",
//        "제주도" : "대한민국, 제주특별자치도"
//    ] //Temp data
    
    
//    var locationItemKeys: [String] {
//           return Array(locationItems.keys) // Dictionary의 키를 배열로 변환
//    }
    
  
    
    // Combine을 사용하여 버튼 클릭 이벤트를 처리할 수 있는 퍼블리셔
//    var backButtonTapped: AnyPublisher<Void, Never> {
//        return backButtonSubject.eraseToAnyPublisher()
//    }
    
//    var rightButtonTapped: AnyPublisher<Void, Never> {
//        return rightButtonSubject.eraseToAnyPublisher()
//    }
    
    
//    var completeButtonTapped: AnyPublisher<Void, Never> {
//        return completeButtonSubject.eraseToAnyPublisher()
//    }
    
    
    var textViewEditingChanged: AnyPublisher<String, Never> {
        return textViewEditingChangedSubject.eraseToAnyPublisher()
    }
    
    
    var openAddCategoryButtonTapped: AnyPublisher<Void, Never> {
        return openAddCategorySubject.eraseToAnyPublisher()
    }
    
    var openAddLocationButtonTapped: AnyPublisher<Void, Never> {
        return openAddLocationSubject.eraseToAnyPublisher()
    }
    
    var openAddDateButtonTapped: AnyPublisher<Void, Never> {
        return openAddDateSubject.eraseToAnyPublisher()
    }
    
    
//    var addCategoryItem: AnyPublisher<Void, Never> {
//        return openAddLocationSubject.eraseToAnyPublisher()
//    }
//    
////    var addLocationItem: AnyPublisher<Void, Never> {
////        return openAddLocationSubject.eraseToAnyPublisher()
////    }
    
    var lessTabbed: AnyPublisher<Void, Never> {
        return categoryLessSubject.eraseToAnyPublisher()
    }
    
    var normalTabbed: AnyPublisher<Void, Never> {
        return categoryNormalSubject.eraseToAnyPublisher()
    }
    
    var moreTabbed: AnyPublisher<Void, Never> {
        return categoryMoreSubject.eraseToAnyPublisher()
    }
    
    
//    private let backButtonSubject = PassthroughSubject<Void, Never>()
//    private let rightButtonSubject = PassthroughSubject<Void, Never>()
    
//    private let completeButtonSubject = PassthroughSubject<Void, Never>()
    
    private let openAddCategorySubject = PassthroughSubject<Void, Never>()
    private let openAddLocationSubject = PassthroughSubject<Void, Never>()
    private let openAddDateSubject = PassthroughSubject<Void, Never>()

//    private let addCategorySubject = PassthroughSubject<Void, Never>()
//    private let addLocationSubject = PassthroughSubject<Void, Never>()

//    private let textViewBeginEditingSubject = PassthroughSubject<Void, Never>()
//    private let textViewEndEditingSubject = PassthroughSubject<Void, Never>()
    private let textViewEditingChangedSubject = PassthroughSubject<String, Never>()
    
    private let categoryLessSubject = PassthroughSubject<Void, Never>()
    private let categoryNormalSubject = PassthroughSubject<Void, Never>()
    private let categoryMoreSubject = PassthroughSubject<Void, Never>()

    
//    func backButtonAction() {
//        backButtonSubject.send()
//    }
    
//    func rightButtonAction() {
//        rightButtonSubject.send()
//    }
    
    
    
//    func myTextViewDidBeginEditing() {
//        textViewBeginEditingSubject.send()
//    }
//    
//    func myTextViewDidEndEditing() {
//        textViewEndEditingSubject.send()
//    }
    
//    func completeBtnAction(){
//        completeButtonSubject.send()
//    }
    
    
    func openAddCategoryVC() {
        openAddCategorySubject.send()
    }
    
    func openAddLocationVC() {
        openAddLocationSubject.send()
    }
    
    func openAddDateVC(){
        openAddDateSubject.send()
    }
    
    
    func writingTitle(_ text: String) {
        textViewEditingChangedSubject.send(text)
        if tripName.count <= 20 {
            tripName = text
            print(tripName)
        }
    }
    
    func selectLess(){
        categoryLessSubject.send()
        packagePrepareType = "적게"
    }
    
    func selectNormal(){
        categoryNormalSubject.send()
        packagePrepareType = "보통"
    }
    
    func selectMore(){
        categoryMoreSubject.send()
        packagePrepareType = "많이"
    }
    
    
//    func addSelectedCategoryElement(element: String) {
//        addCategorySubject.send()
//        if !selectedCategoryItems.contains(element){
//            selectedCategoryItems.append(element)
//        }
//    }
//    
//    func removeSelectedCategoryElement(element: String) {
//        if selectedCategoryItems.contains(element){
//            if let index = selectedCategoryItems.firstIndex(of: element) {
//                selectedCategoryItems.remove(at: index)
//            }
//        }
//    }
    
//    func addSelectedLocationElement(element: String) {
//        addLocationSubject.send()
//        if !selectedLocationItems.contains(element){
//            selectedLocationItems.append(element)
//        }
//    }
//    
//    func removeSelectedLocationElement(element: String) {
//        if let index = selectedLocationItems.firstIndex(of: element) {
//            selectedLocationItems.remove(at: index)
//        }
//    }
    

}

















/*
 class SelectedItemsViewModel: ObservableObject {
     @Published var items: [String] = [] // 선택된 아이템 배열

     func addItem(_ item: String) {
         items.append(item)
     }

     func removeItem(at index: Int) {
         guard index < items.count else { return }
         items.remove(at: index)
     }
 }
 
 
 ViewController에서
 
 private func bindViewModel() {
     // ViewModel의 items 배열을 구독
     viewModel.$items // $ 기호는 @Published 속성의 퍼블리셔에 접근하기 위해 사용됩
         .receive(on: RunLoop.main) // 퍼블리셔가 발행하는 값을 메인 스레드에서 수신(UI 업데이트)
         .sink { [weak self] items in
             self?.updateCollectionView(with: items)
         }
         .store(in: &cancellables)
 }
 
 private func updateCollectionView(with items: [String]) {
     // UICollectionView 업데이트
     selectedItemsCollectionView.selectedItemsCollectionView.reloadData()
     
     // 애니메이션으로 높이 변경
     UIView.animate(withDuration: 0.3) {
         self.selectedItemsCollectionView.snp.updateConstraints { make in
             make.height.equalTo(items.isEmpty ? 0 : 50) // 아이템이 없으면 높이를 0으로, 있으면 50으로
         }
         self.view.layoutIfNeeded() // 레이아웃 업데이트
     }
 }
 
 func addSelectedItem(itemName: String) {
     viewModel.addItem(itemName) // ViewModel에 아이템 추가
 }
 
 func removeSelectedItem(at index: Int) {
     viewModel.removeItem(at: index) // ViewModel에서 아이템 제거
 }
 
 */
