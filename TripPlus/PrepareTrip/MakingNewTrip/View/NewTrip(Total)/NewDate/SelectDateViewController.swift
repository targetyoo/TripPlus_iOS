//
//  SelectDateViewController.swift
//  TripPlus
//
//  Created by 유대상 on 2/9/25.
//
import UIKit
import Combine
import FSCalendar

protocol SelectDateDelegate: AnyObject {
    func finishSelectDate(arriveDate:String, departDate:String)
}

class SelectDateViewController: UIViewController{
    var viewModel = MakeDateViewModel()
    var navigationVM = NavigationViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: SelectDateDelegate?

//    private var firstDate: Date?    // 배열 중 첫번째 날짜
//    private var lastDate: Date?        // 배열 중 마지막 날짜
//    private var datesRange: [Date] = []    // 선택된 날짜 배열
    
    private lazy var contentView: SelectDateView = {
        let view = SelectDateView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 20
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedDates: [Date] = [] // 선택된 날짜를 저장할 배열
//    private var isSelectingRange = false // 범위 선택 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        bindViewModel()
    }
    
    func setViews(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        backgroundView.addGestureRecognizer(tapGesture)
        
        viewModel.formattedMonth = viewModel.dateFormatter(date: Date().addingTimeInterval(TimeInterval(TimeZone(identifier: "Asia/Seoul")!.secondsFromGMT())), includeDay: false)
        contentView.monthLabel.text = viewModel.formattedMonth
        
        self.view.backgroundColor = .clear
        [backgroundView, contentView].forEach({self.view.addSubview($0)})
//        self.view.bringSubviewToFront(contentView)
        backgroundView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        contentView.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(450.0)
            make.centerY.equalToSuperview().offset(25.0)
        })
        contentView.calendarView.delegate = self
        contentView.calendarView.dataSource = self
        
        
        contentView.departureDateBtn.setTitle(viewModel.dateFormatter(date:  Calendar.current.startOfDay(for: Date()), includeDay: true), for: .normal)
        contentView.arrivalDateBtn.setTitle(viewModel.dateFormatter(date: Calendar.current.startOfDay(for: Date() + 60*60*24), includeDay: true), for: .normal)
        
//        contentView.departureDateBtn.publisher(for: .touchUpInside)
//            .sink { [weak self] _ in
//                
//            }
//            .store(in: &cancellables)
//        
//        contentView.arrivalDateBtn.publisher(for: .touchUpInside)
//            .sink { [weak self] _ in
//                
//            }
//            .store(in: &cancellables)
        
        contentView.previousMonthBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let currentMonth = self?.contentView.calendarView.currentPage
                self?.contentView.calendarView.select(Calendar.current.date(byAdding: .month, value: -1, to: currentMonth!), scrollToDate: true)
            }
            .store(in: &cancellables)
        
        contentView.nextMonthBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                let currentMonth = self?.contentView.calendarView.currentPage
                self?.contentView.calendarView.select(Calendar.current.date(byAdding: .month, value: 1, to: currentMonth!), scrollToDate: true)
            }
            .store(in: &cancellables)
        
        contentView.cancelBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.backButtonAction()
            }
            .store(in: &cancellables)
        
        contentView.confirmBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.completeBtnAction()
            }
            .store(in: &cancellables)
        
    }
    
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }
    
    func bindViewModel(){
        navigationVM.backButtonTapped
            .sink { [weak self] in
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        navigationVM.completeButtonTapped
            .sink { [weak self] in
                self?.delegate?.finishSelectDate(arriveDate: "", departDate: "")
                self?.dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.$datesRange
            .sink { [weak self] _ in
                self?.contentView.calendarView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$formattedMonth
            .sink{ [weak self] formattedMonth in
                self?.contentView.monthLabel.text = formattedMonth
            }
            .store(in: &cancellables)
        
        viewModel.$firstDate
            .receive(on: RunLoop.main)
            .sink { [weak self] _firstDate in
                if let firstDate = _firstDate{
                    let dateString = self?.viewModel.dateFormatter(date: firstDate, includeDay: true)
                    self?.contentView.departureDateBtn.setTitle(dateString, for: .normal)
                    self?.contentView.departureDateBtn.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.5)
                    self?.contentView.departureDateBtn.layer.borderWidth = DesignSystem.Calendar.button_Selected_BorderWidth
                    self?.contentView.departureDateBtn.setTitleColor(UIColor(named: "grayA"), for: .normal)
                    
                    self?.viewModel.finalDepartDate = dateString!
                }else{
                    self?.viewModel.finalDepartDate = ""
                    self?.contentView.departureDateBtn.backgroundColor = UIColor(named: "grayC")?.withAlphaComponent(0.5)
                    self?.contentView.departureDateBtn.setTitleColor(UIColor(named: "grayB"), for: .normal)
                    self?.contentView.departureDateBtn.layer.borderWidth = 0.0
                }
                self?.checkDateSelectFinish()
            }
            .store(in: &cancellables)
        
        viewModel.$lastDate
            .receive(on: RunLoop.main)
            .sink { [weak self] _lastDate in
                if let lastDate = _lastDate{
                    let dateString = self?.viewModel.dateFormatter(date: lastDate, includeDay: true)
                    self?.contentView.arrivalDateBtn.setTitle(dateString, for: .normal)
                    self?.contentView.arrivalDateBtn.backgroundColor = UIColor(named: "tripGreen")?.withAlphaComponent(0.5)
                    self?.contentView.arrivalDateBtn.layer.borderWidth = DesignSystem.Calendar.button_Selected_BorderWidth
                    self?.contentView.arrivalDateBtn.setTitleColor(UIColor(named: "grayA"), for: .normal)
                    
                    self?.viewModel.finalArriveDate = dateString!
                }else{
                    self?.viewModel.finalArriveDate = ""
                    self?.contentView.arrivalDateBtn.backgroundColor = UIColor(named: "grayC")?.withAlphaComponent(0.5)
                    self?.contentView.arrivalDateBtn.setTitleColor(UIColor(named: "grayB"), for: .normal)
                    self?.contentView.arrivalDateBtn.layer.borderWidth = 0.0
                }
                self?.checkDateSelectFinish()
            }
            .store(in: &cancellables)
        
        
        
//        viewModel.departDateBtnTapped
//            .sink { [weak self] in
//                //출발 날짜 설정 모드
//            }
//            .store(in: &cancellables)
//        
//        viewModel.arrivalDateBtnTapped
//            .sink { [weak self] in
//                //도착 날짜 설정 모드
//            }
//            .store(in: &cancellables)
    }
    
    func checkDateSelectFinish(){
        if viewModel.finalArriveDate != "" && viewModel.finalDepartDate != "" {
            print("All Date Selected -")
            print("finalDepartDate : \(viewModel.finalDepartDate)")
            print("finalArriveDate : \(viewModel.finalArriveDate)")
            
            contentView.confirmBtn.isUserInteractionEnabled = true
            contentView.confirmBtn.backgroundColor = UIColor(named: "tripGreen")
            contentView.confirmBtn.setTitleColor(UIColor(named: "grayC"), for: .normal)
        }else{
            contentView.confirmBtn.isUserInteractionEnabled = false
            contentView.confirmBtn.backgroundColor = UIColor(named: "grayC")
            contentView.confirmBtn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        }
    }
}

extension SelectDateViewController: FSCalendarDataSource, FSCalendarDelegate{
    // 매개변수로 들어온 date의 타입을 반환한다
       func typeOfDate(_ date: Date) -> SelectedDateType {
           let arr = viewModel.datesRange
//           let arr = datesRange
           
           if !arr.contains(date) {
               return .notSelectd    // 배열이 비어있으면 무조건 notSelected
           }
           
           else {
               // 배열의 count가 1이고, firstDate라면 singleDate
               if arr.count == 1 && date == viewModel.firstDate { return .singleDate }
               
               // 배열의 count가 2 이상일 때, 각각 타입 반환
               if date == viewModel.firstDate { return .firstDate }
               if date == viewModel.lastDate { return .lastDate }
               
               else { return .middleDate }
           }
       }

       func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
           guard let cell = calendar.dequeueReusableCell(withIdentifier: DateCollectionViewCell.identifier, for: date, at: position) as? DateCollectionViewCell else { return FSCalendarCell() }
           
           // 현재 그리는 셀의 date의 타입에 기반해서 셀 디자인
           cell.updateBackImage(typeOfDate(date))
           
           var calendar = Calendar.current
           let currentDate = Date()
           let kstTimeZone = TimeZone(identifier: "Asia/Seoul")!
           calendar.timeZone = kstTimeZone
           
           // KST 기준으로 현재 날짜의 시작 부분(00:00:00)으로 설정
//           let currentDateInKST = calendar.startOfDay(for: currentDate.addingTimeInterval(TimeInterval(kstTimeZone.secondsFromGMT())))
             let currentDateInKST = calendar.startOfDay(for: currentDate)

           // date의 KST 기준 시작 부분(00:00:00)으로 설정
           let dateInKST = calendar.startOfDay(for: date.addingTimeInterval(TimeInterval(kstTimeZone.secondsFromGMT())))
//           let dateInKST = calendar.startOfDay(for: date)

           
           if calendar.isDate(dateInKST, inSameDayAs: currentDateInKST){
               cell.centerView.backgroundColor = UIColor(named: "tripOrange")
               cell.titleLabel.textColor = UIColor(named: "grayD")
               cell.centerView.isHidden = false
               
               if typeOfDate(date) == .firstDate || typeOfDate(date) == .lastDate || typeOfDate(date) == .singleDate{
                   cell.centerView.backgroundColor = UIColor(named: "tripGreen")
                   cell.titleLabel.textColor = UIColor(named: "grayD")
                   cell.updateBackImage(typeOfDate(date))
               }
           }else{
               cell.centerView.backgroundColor = UIColor(named: "tripGreen")
               cell.titleLabel.textColor = UIColor(named: "grayD")
           }
           return cell
       }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.didSelectDate(date, calendar: calendar)
        }
    
    // 이미 선택된 날짜들 중 하나를 선택 -> 선택된 날짜 모두 초기화
       func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
           viewModel.didDeselectDate(date, calendar: calendar)
       }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("calendar \(calendar.currentPage)")
        
        let pagetitle = viewModel.dateFormatter(date: calendar.currentPage, includeDay: false)
        contentView.monthLabel.text = pagetitle
        //depart/arriveBtn border랑 confirm만 체크하면 되겠다
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, cellSizeFor date: Date) -> CGSize {
        let cellWidth = 20.0 // 각 셀의 너비 계산
        let cellHeight = 22.0 // 원하는 셀 높이 설정
        
        return CGSize(width: cellWidth, height: cellHeight) // 셀 크기 반환
    }
}
