//
//  MyTripPackageViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class MyTripPackageViewController: UIViewController {
    
    private var viewModel = MyTripPageViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    func setPackageData(departDate: String, arriveDate: String, location: String){
        myTripDate.text = "\(departDate) → \(arriveDate)"
        myTripDday.text = "D-999"
        myTripLocation.text = location
    }
    
    private let cellHeight: CGFloat = 65.0
    private var defaultCellNumber: CGFloat = 0
    private let expandedCellHeight: CGFloat = 160.0 // 확장된 셀 높이
    
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var packagePreviewContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.snp.makeConstraints({ make in
            make.height.equalTo(235.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var myTripDday: UILabel = {
        let label = UILabel()
        label.text = "D-000"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var myTripProgressTitle: UILabel = {
        let label = UILabel()
        label.text = "여행 준비도"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripProgress: UILabel = {
        let label = UILabel()
        label.text = "00%"
        label.textColor = UIColor(named: "tripGreen")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripProgressbar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.setProgress(0.0, animated: false)
        progressView.progressTintColor = UIColor(named: "tripOrange")
        progressView.snp.makeConstraints({ make in
            make.height.equalTo(2.0)
        })
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    private lazy var myTripDateIcon: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "travelPeriod")
        imgView.tintColor = UIColor(named: "grayB")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        return imgView
    }()
    
    private lazy var myTripDate: UILabel = {
        let label = UILabel()
        label.text = "00.00.00 → 00.00.00"
        label.textColor = UIColor(named: "grayA")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripLocationIcon: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "travelLocation")
        imgView.tintColor = UIColor(named: "grayB")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        return imgView
    }()
    
    private lazy var myTripLocation: UILabel = {
        let label = UILabel()
        label.text = "목적지"
        label.textColor = UIColor(named: "grayA")
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayC")
        view.snp.makeConstraints({ make in
            make.height.equalTo(10.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var tableContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var companionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70.0, height: 30.0)
        layout.minimumLineSpacing = 12.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CompanionCollectionViewCell.self, forCellWithReuseIdentifier: CompanionCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var packageTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.layer.cornerRadius = 14.0
        tableView.register(PackageTableViewCell.self, forCellReuseIdentifier: PackageTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.separatorStyle = .none
        tableView.tintAdjustmentMode = .normal
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultCellNumber = CGFloat(self.viewModel.tableTempData.count + 1)
        setViews()
        setProgress()
    }
    
    private func setProgress(){
        var checkedCount: Float = 0.0
        for item in self.viewModel.tableTempData {
            if item.isChecked{
                checkedCount = checkedCount + 1.0
            }
        }
        
        self.myTripProgressbar.setProgress(checkedCount / Float(self.viewModel.tableTempData.count), animated: true)
        print("prg: \(myTripProgressbar.progress)")
    }
    
    private func setViews(){
        self.view.backgroundColor = .white

        [ myTripDday,
          myTripProgressTitle, myTripProgress, myTripProgressbar,
          myTripDateIcon, myTripDate,
          myTripLocationIcon, myTripLocation ].forEach({ self.packagePreviewContentView.addSubview($0) })
        tableContentView.addSubview(packageTableView)
        [ packagePreviewContentView, borderView, companionCollectionView, tableContentView ].forEach({ self.scrollContentView.addSubview($0) })
        self.scrollView.addSubview(scrollContentView)
        self.view.addSubview(scrollView)
        
        myTripDday.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(40.0)
        })
        
        myTripProgressTitle.snp.makeConstraints({ make in
            make.top.equalTo(myTripDday.snp.bottom).offset(15.0)
            make.leading.equalTo(myTripDday.snp.leading)
        })
        myTripProgress.snp.makeConstraints({ make in
            make.top.equalTo(myTripProgressTitle.snp.top)
            make.trailing.equalToSuperview().offset(-40.0)
        })
        myTripProgressbar.snp.makeConstraints({ make in
            make.top.equalTo(myTripProgressTitle.snp.bottom)
            make.leading.equalTo(myTripProgressTitle.snp.leading)
            make.trailing.equalTo(myTripProgress.snp.trailing)
        })
        
        myTripDateIcon.snp.makeConstraints({ make in
            make.top.equalTo(myTripProgressbar.snp.bottom).offset(15.0)
            make.leading.equalTo(myTripDday.snp.leading)
        })
        myTripDate.snp.makeConstraints({ make in
            make.centerY.equalTo(myTripDateIcon.snp.centerY)
            make.leading.equalTo(myTripDateIcon.snp.trailing).offset(20.0)
        })
        myTripLocationIcon.snp.makeConstraints({ make in
            make.top.equalTo(myTripDateIcon.snp.bottom).offset(15.0)
            make.leading.equalTo(myTripDday.snp.leading)
        })
        myTripLocation.snp.makeConstraints({ make in
            make.centerY.equalTo(myTripLocationIcon.snp.centerY)
            make.leading.equalTo(myTripLocationIcon.snp.trailing).offset(20.0)
            make.trailing.equalToSuperview().offset(-40.0)
        })
        
        packagePreviewContentView.snp.makeConstraints({ make in
            make.top.leading.trailing.equalToSuperview()
        })
        
        borderView.snp.makeConstraints({ make in
            make.top.equalTo(packagePreviewContentView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
        
        
        companionCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(borderView.snp.bottom).offset(20.0)
            make.height.equalTo(30.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        companionCollectionView.isHidden = false
        
        tableContentView.snp.makeConstraints({ make in
            make.top.equalTo(companionCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        })
        packageTableView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(20.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(cellHeight * defaultCellNumber)
        })
        
        scrollContentView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.view.bounds.width)
        })
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })

    }
    
    func setTestValues(testValue: Int){
        myTripLocation.text = "테스트 - \(testValue)번째 페이지"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    private func adjustContentViewHeight(isAdd: Bool) {
        defaultCellNumber = CGFloat(self.viewModel.tableTempData.count + 1)
        
        var tableHeight: CGFloat = 0.0
        
        for i in 0..<self.viewModel.tableTempData.count {
            if self.viewModel.tableTempData[i].isExpanded {
                tableHeight += expandedCellHeight
            }else{
                tableHeight += cellHeight
            }
        }
        //추가버튼의 높이
        tableHeight += cellHeight
        print("==================================")
        print("packageTableView :\(tableHeight)")

        self.packageTableView.snp.updateConstraints({ make in
            make.height.equalTo(tableHeight)
        })
        packageTableView.reloadData()
        
        if isAdd{ //Item을 더하는 상태라면, 기존 contentOffset에서 expand된 만큼만 늘려준다
            let currentContentOffset = scrollView.contentOffset
            scrollView.setContentOffset(CGPoint(x: 0, y: currentContentOffset.y + cellHeight), animated: true)
        }else { //그 외의 상태라면, contentOffset을 맨 아래로 내려준다
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
}







extension MyTripPackageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tempCompanion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanionCollectionViewCell.identifier, for: indexPath) as! CompanionCollectionViewCell
        
        cell.configure(name: viewModel.tempCompanion[indexPath.row])
        
        return cell
    }    
}









extension MyTripPackageViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func addNewData() {
        viewModel.tableTempData.append(PackageCellData(title: "미니선풍기", icon: UIImage(systemName: "battery.100"), description: "", isExpanded: false))
        self.adjustContentViewHeight(isAdd: true)
    }
    
    private func toggleCellExpansion(at indexPath: IndexPath) {
        // 확장 상태 토글
        let wasExpanded = viewModel.tableTempData[indexPath.row].isExpanded
        viewModel.tableTempData[indexPath.row].isExpanded.toggle()
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // 테이블 뷰 높이 업데이트
            self.packageTableView.beginUpdates()
            self.packageTableView.endUpdates()
            
            // 셀 내부 콘텐츠 애니메이션 동기화
            if let cell = self.packageTableView.cellForRow(at: indexPath) as? PackageTableViewCell {
                cell.animateExpansion(isExpanded: self.viewModel.tableTempData[indexPath.row].isExpanded)
            }

            var tableHeight: CGFloat = 0.0
            
            for i in 0..<self.viewModel.tableTempData.count {
                if self.viewModel.tableTempData[i].isExpanded {
                    tableHeight += self.expandedCellHeight
                }else{
                    tableHeight += self.cellHeight
                }
            }
            //추가버튼의 높이
            tableHeight += self.cellHeight
            print("packageTableView :\(tableHeight)")

            self.packageTableView.snp.updateConstraints({ make in
                make.height.equalTo(tableHeight)
            })
        
        }, completion: nil)

//        if !wasExpanded{
//            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
//            scrollView.setContentOffset(bottomOffset, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableTempData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifier, for: indexPath) as! PackageTableViewCell
        cell.contentView.backgroundColor = UIColor(named: "grayC")
        
        if viewModel.tableTempData.count == indexPath.row {
            cell.configure(with: "", icon: UIImage(systemName: "circle.dotted")!, isExpanded: false, description: "")
            cell.onInfoButtonTapped = nil
            return cell
        }
        
        let item = viewModel.tableTempData[indexPath.row]
        cell.configure(with: item.title, icon: item.icon, isExpanded: item.isExpanded, description: viewModel.tableTempData[indexPath.row].description, needChecking: true)
        cell.isChecked(checked: self.viewModel.tableTempData[indexPath.row].isChecked)
        cell.onInfoButtonTapped = { [weak self] in
            self?.toggleCellExpansion(at: indexPath)
        }
        
        cell.onCheckButtonTapped = { [weak self] in
            //TODO: Data check
            if self?.viewModel.tableTempData[indexPath.row].isChecked == true{
                self?.viewModel.tableTempData[indexPath.row].isChecked = false
                cell.isChecked(checked: false)
                self?.setProgress()
            }else{
                self?.viewModel.tableTempData[indexPath.row].isChecked = true
                cell.isChecked(checked: true)
                self?.setProgress()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 데이터 추가 셀에서만 터치 이벤트 처리
        if indexPath.row == viewModel.tableTempData.count {
            addNewData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row == viewModel.tableTempData.count {
            return nil // 데이터 추가 셀에는 스와이프 동작 비활성화
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            // 데이터 삭제
            self?.viewModel.tableTempData.remove(at: indexPath.row)
            // 테이블 뷰에서 셀 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // 높이 업데이트
//            self?.updateTableViewHeight()
            
            self?.adjustContentViewHeight(isAdd: false)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(named: "tripOrange")
        deleteAction.image = UIImage(named: "trashcan")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == viewModel.tableTempData.count {
            return cellHeight
        }
        
        let item = viewModel.tableTempData[indexPath.row]
        return item.isExpanded ? expandedCellHeight : cellHeight
    }
}
