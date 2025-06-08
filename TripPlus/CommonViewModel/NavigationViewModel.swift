//
//  NavigationViewModel.swift
//  TripPlus
//
//  Created by andev on 6/2/25.
//

import Foundation
import Combine

class NavigationViewModel{
    var backButtonTapped: AnyPublisher<Void, Never> {
        return backButtonSubject.eraseToAnyPublisher()
    }
    
    var completeButtonTapped: AnyPublisher<Void, Never> {
        return completeButtonSubject.eraseToAnyPublisher()
    }
    
    
    private let backButtonSubject = PassthroughSubject<Void, Never>()
    
    private let completeButtonSubject = PassthroughSubject<Void, Never>()

    
    func backButtonAction() {
        backButtonSubject.send()
    }
    
    func completeBtnAction(){
        completeButtonSubject.send()
    }
    
}
