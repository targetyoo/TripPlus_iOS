//
//  MakeDateViewModel.swift
//  TripPlus
//
//  Created by andev on 6/2/25.
//

import Foundation
import Combine
import FSCalendar

//MARK: Service를 이용하여 Data 전달
class MakeDateService {
    @Published var finalDepartDate: String = ""
    @Published var finalArriveDate: String = ""
}


class MakeDateViewModel{
    @Published var formattedMonth: String = ""
    
    @Published var finalDepartDate: String = ""
    @Published var finalArriveDate: String = ""
//    @Published var departDate: Date = Date()
//    @Published var arriveDate: Date = Date() + 24*60*60
    
    @Published var datesRange: [Date] = []
    @Published var firstDate: Date?
    @Published var lastDate: Date?
    
    func didSelectDate(_ date: Date, calendar: FSCalendar) {
        // case 1. 현재 아무것도 선택되지 않은 경우
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            return
        }
        // case 2. 현재 firstDate 하나만 선택된 경우
        if firstDate != nil && lastDate == nil {
            // case 2 - 1. firstDate 이전 날짜 선택 -> firstDate 변경
            if date < firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                return
            }
            // case 2 - 2. firstDate 이후 날짜 선택 -> 범위 선택
            else {
                var range: [Date] = []
                var currentDate = firstDate!
                while currentDate <= date {
                    range.append(currentDate)
                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                }
                for day in range {
                    calendar.select(day)
                }
                lastDate = range.last
                datesRange = range
                return
            }
        }
        // case 3. 두 개가 모두 선택되어 있는 상태 -> 현재 선택된 날짜 모두 해제 후 선택 날짜를 firstDate로 설정
        if firstDate != nil && lastDate != nil {
            for day in calendar.selectedDates {
                calendar.deselect(day)
            }
            lastDate = nil
            firstDate = date
            calendar.select(date)
            datesRange = [firstDate!]
            return
        }
    }
    
    func didDeselectDate(_ date: Date, calendar: FSCalendar) {
        let arr = datesRange
        if !arr.isEmpty {
            for day in arr {
                calendar.deselect(day)
            }
        }
        firstDate = nil
        lastDate = nil
        datesRange = []
    }
    
    func dateFormatter(date: Date = Date(), includeDay: Bool) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = includeDay ? "yyyy년 MM월 dd일" : "yyyy년 MM월"
        return formatter.string(from: date)
    }
    
    var departDateBtnTapped: AnyPublisher<Void, Never> {
        return departDateBtnSubject.eraseToAnyPublisher()
    }
    
    var arrivalDateBtnTapped: AnyPublisher<Void, Never> {
        return arrivalDateBtnSubject.eraseToAnyPublisher()
    }
    
    
    private let departDateBtnSubject = PassthroughSubject<Void, Never>()
    
    private let arrivalDateBtnSubject = PassthroughSubject<Void, Never>()

    
    func departDateBtnAction() {
        departDateBtnSubject.send()
    }
    
    func arriveDateBtnAction() {
        arrivalDateBtnSubject.send()
    }
    
}




