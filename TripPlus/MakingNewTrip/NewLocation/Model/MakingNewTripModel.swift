//
//  MakingNewTripModel.swift
//  TripPlus
//
//  Created by 유대상 on 1/8/25.
//

import Foundation
import Combine

class MakingNewTripModel {
    // Combine을 사용하여 버튼 클릭 이벤트를 처리할 수 있는 퍼블리셔
    var backButtonTapped: AnyPublisher<Void, Never> {
        return backButtonSubject.eraseToAnyPublisher()
    }
    
    var rightButtonTapped: AnyPublisher<Void, Never> {
        return rightButtonSubject.eraseToAnyPublisher()
    }
    
    var textViewDidBeginEditing: AnyPublisher<Void, Never> {
        return textViewBeginEditingSubject.eraseToAnyPublisher()
    }
    
    var textViewDidEndEditing: AnyPublisher<Void, Never> {
        return textViewEndEditingSubject.eraseToAnyPublisher()
    }
    
    private let backButtonSubject = PassthroughSubject<Void, Never>()
    private let rightButtonSubject = PassthroughSubject<Void, Never>()
    private let textViewBeginEditingSubject = PassthroughSubject<Void, Never>()
       private let textViewEndEditingSubject = PassthroughSubject<Void, Never>()
    
    func backButtonAction() {
        backButtonSubject.send()
    }
    
    func rightButtonAction() {
        rightButtonSubject.send()
    }
    
    func myTextViewDidBeginEditing() {
        textViewBeginEditingSubject.send()
    }
    
    func myTextViewDidEndEditing() {
        textViewEndEditingSubject.send()
    }
}
