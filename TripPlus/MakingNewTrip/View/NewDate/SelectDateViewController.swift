//
//  SelectDateViewController.swift
//  TripPlus
//
//  Created by 유대상 on 2/9/25.
//
import UIKit
import Combine
import FSCalendar


class SelectDateViewController: UIViewController{
    
    private var firstDate: Date?    // 배열 중 첫번째 날짜
        private var lastDate: Date?        // 배열 중 마지막 날짜
        private var datesRange: [Date] = []    // 선택된 날짜 배열
    
    private lazy var contentView: SelectDateView = {
        let view = SelectDateView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 10, height: 3)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 12
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedDates: [Date] = [] // 선택된 날짜를 저장할 배열
    private var isSelectingRange = false // 범위 선택 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews(){
        self.view.backgroundColor = .clear
        self.view.addSubview(contentView)
        
        contentView.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().offset(-10.0)
            make.height.equalTo(contentView.snp.width)
            make.centerY.equalToSuperview().offset(25.0)
        })
        contentView.calendarView.delegate = self
        contentView.calendarView.dataSource = self
        
//        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didTapDateCell(gesture:)))
//        panGensture.minimumPressDuration = 0.5
//        contentView.calendarView.addGestureRecognizer(panGensture)
    }
    
//    @objc func didTapDateCell(gesture: UITapGestureRecognizer) {
//        let point = gesture.location(in: contentView.calendarView)
//        guard let indexPath = contentView.calendarView.indexPathForItem(at: point) else { return }
////        let date = contentView.calendarView.date(for: indexPath)
//        let cellState = contentView.calendarView.cellStatusForDate(at: indexPath.section, column: indexPath.row)
//        let date = cellState!.date
//                
//           if isSelectingRange {
//               // 범위 선택 모드에서 날짜 추가
//               if let firstDate = selectedDates.first {
//                   let range = contentView.calendarView.generateDateRange(from: firstDate, to: date)
//                   selectedDates = Array(range) // 선택된 날짜 범위 업데이트
//               }
//           } else {
//               // 단일 선택 모드에서 날짜 추가
//               selectedDates = [date] // 선택된 날짜 업데이트
//               isSelectingRange = true // 범위 선택 모드로 전환
//           }
//           
//        contentView.calendarView.reloadData() // 캘린더 업데이트
//       }
}

extension SelectDateViewController: FSCalendarDataSource, FSCalendarDelegate{
    // 매개변수로 들어온 date의 타입을 반환한다
       func typeOfDate(_ date: Date) -> SelectedDateType {
           
           let arr = datesRange
           
           if !arr.contains(date) {
               return .notSelectd    // 배열이 비어있으면 무조건 notSelected
           }
           
           else {
               // 배열의 count가 1이고, firstDate라면 singleDate
               if arr.count == 1 && date == firstDate { return .singleDate }
               
               // 배열의 count가 2 이상일 때, 각각 타입 반환
               if date == firstDate { return .firstDate }
               if date == lastDate { return .lastDate }
               
               else { return .middleDate }
           }
       }

       func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
           guard let cell = calendar.dequeueReusableCell(withIdentifier: DateCollectionViewCell.identifier, for: date, at: position) as? DateCollectionViewCell else { return FSCalendarCell() }

           // 현재 그리는 셀의 date의 타입에 기반해서 셀 디자인
//           cell.updateBackImage(typeOfDate(date))

           return cell
       }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
            // case 1. 현재 아무것도 선택되지 않은 경우
                // 선택 date -> firstDate 설정
            if firstDate == nil {
                firstDate = date
                datesRange = [firstDate!]
                
                contentView.calendarView.reloadData() // (매번 reload)
                return
            }
            
            // case 2. 현재 firstDate 하나만 선택된 경우
            if firstDate != nil && lastDate == nil {
                // case 2 - 1. firstDate 이전 날짜 선택 -> firstDate 변경
                if date < firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]
                    
                    contentView.calendarView.reloadData()    // (매번 reload)
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
                    
                    contentView.calendarView.reloadData()    // (매번 reload)
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
                    
                contentView.calendarView.reloadData()    // (매번 reload)
                return
            }
            
            
        }
    
    // 이미 선택된 날짜들 중 하나를 선택 -> 선택된 날짜 모두 초기화
       func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
       
           let arr = datesRange
           if !arr.isEmpty {
               for day in arr {
                   calendar.deselect(day)
               }
           }
           firstDate = nil
           lastDate = nil
           datesRange = []
           
           contentView.calendarView.reloadData()    // (매번 reload)
       }
}

//extension SelectDateViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
//
//    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, willDisplay cell: JTAppleCalendar.JTACDayCell, forItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) {
//        configureCell(view: cell, cellState: cellState)
//        handleCellSelection(view: cell, cellState: cellState)
//    }
//    
//    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, cellForItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) -> JTAppleCalendar.JTACDayCell {
//        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
////        cell.dateLabel.text = cellState.text
//
//        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
//
//                return cell
//    }
//    
//    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy MM dd"
//        let startDate = formatter.date(from: "2020 01 01")!
//        let endDate = Date()
//        return ConfigurationParameters(startDate: startDate, endDate: endDate)
//    }
//    
//
//
//
//    
//    
//    func configureCell(view: JTACDayCell?, cellState: CellState) {
//       guard let cell = view as? DateCollectionViewCell  else { return }
//       cell.dateLabel.text = cellState.text
//       handleCellTextColor(cell: cell, cellState: cellState)
////        handleCellSelected(cell: cell, cellState: cellState)
//    }
//
//    func handleCellTextColor(cell: DateCollectionViewCell, cellState: CellState) {
//       if cellState.dateBelongsTo == .thisMonth {
//           cell.dateLabel.textColor = UIColor(named: "grayA")
//       } else {
//          cell.dateLabel.textColor = UIColor(named: "grayB")
//       }
//    }
//    
////    func handleCellSelected(cell: DateCollectionViewCell, cellState: CellState) {
//////        if cellState.isSelected {
//////            cell.selectedView.layer.cornerRadius = 13
//////            cell.selectedView.isHidden = false
//////        } else {
//////            cell.selectedView.isHidden = true
//////        }
////    }
//    
//    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
//        guard let cell = view as? DateCollectionViewCell else {return }
//        
//        print(cellState.text)
//        
//        switch cellState.selectedPosition() {
//        case .full:
//            cell.selectedView.isHidden = false
//            cell.dateLabel.textColor = UIColor(named: "grayD")
////            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
////            cell.selectedView.layer.cornerRadius = cell.selectedView.frame.width / 2
//        case .left:
//            cell.selectedView.isHidden = false
//            cell.dateLabel.textColor = UIColor(named: "grayD")
//            cell.dateLabel.textColor = .white
////            cell.layer.cornerRadius = cell.selectedView.frame.width / 2
////            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
////            cell.layer.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(50.0).cgColor
//
//        case .right:
//            cell.selectedView.isHidden = false
//            cell.dateLabel.textColor = UIColor(named: "grayD")
////            cell.layer.cornerRadius = cell.selectedView.frame.width / 2
////            cell.layer.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(50.0).cgColor
////            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//            
//        case .middle:
//            cell.selectedView.isHidden = true
////            cell.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(50.0)
//        case .none:
//            if cellState.dateBelongsTo == .thisMonth {
//                cell.dateLabel.textColor = UIColor(named: "grayA")
//            } else {
//               cell.dateLabel.textColor = UIColor(named: "grayB")
//            }
//            cell.selectedView.isHidden = true
//        }
//    }
//    
//    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
//        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: DateCollectionViewHeader.identifier, for: indexPath) as! DateCollectionViewHeader
//        return header
//    }
//
//    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
//        return MonthSize(defaultSize: 20)
//    }
//}
//
