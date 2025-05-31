//
//  MyTripPackageViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/31/25.
//

import Foundation
import UIKit
import SnapKit

class MyTripPackageViewController: UIViewController {
    
    func setPackageData(departDate: String, arriveDate: String, location: String){
        myTripDate.text = "\(departDate) → \(arriveDate)"
        myTripDday.text = "D-999"
        myTripLocation.text = location
    }
    
    private var tableTempData: [PackageCellData] = [
        PackageCellData(title: "보조 배터리 1", icon: UIImage(systemName: "battery.100"), isExpanded: false),
        PackageCellData(title: "워터슈즈 1", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 2", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 3", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 4", icon: UIImage(systemName: "shoe.fill"), isExpanded: false)
    ]
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
            make.height.equalTo(255.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var myTripDday: UILabel = {
        let label = UILabel()
        label.text = "D-000"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var myTripProgressTitle: UILabel = {
        let label = UILabel()
        label.text = "여행 준비도"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripProgress: UILabel = {
        let label = UILabel()
        label.text = "00%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripProgressbar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 50.0
        progressView.progressTintColor = .systemOrange
        progressView.snp.makeConstraints({ make in
            make.height.equalTo(2.0)
        })
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    private lazy var myTripDateIcon: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "infoIcon")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        return imgView
    }()
    
    private lazy var myTripDate: UILabel = {
        let label = UILabel()
        label.text = "00.00.00 → 00.00.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var myTripLocationIcon: UIImageView = {
       let imgView = UIImageView()
        imgView.image = UIImage(named: "infoIcon")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
        })
        return imgView
    }()
    
    private lazy var myTripLocation: UILabel = {
        let label = UILabel()
        label.text = "목적지"
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
        defaultCellNumber = CGFloat(self.tableTempData.count + 1)
        setViews()
    }
    
    private func setViews(){
        self.view.backgroundColor = .white

        [ myTripDday,
          myTripProgressTitle, myTripProgress, myTripProgressbar,
          myTripDateIcon, myTripDate,
          myTripLocationIcon, myTripLocation ].forEach({ self.packagePreviewContentView.addSubview($0) })
        tableContentView.addSubview(packageTableView)
        [ packagePreviewContentView, borderView, tableContentView ].forEach({ self.scrollContentView.addSubview($0) })
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
        
        
        tableContentView.snp.makeConstraints({ make in
            make.top.equalTo(borderView.snp.bottom)
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
    
    
    private func adjustContentViewHeight() {
        defaultCellNumber = CGFloat(self.tableTempData.count + 1)
        
        var tableHeight: CGFloat = 0.0
        
        for i in 0..<self.tableTempData.count {
            if self.tableTempData[i].isExpanded {
                tableHeight += expandedCellHeight
            }else{
                tableHeight += cellHeight
            }
        }
        //추가버튼의 높이
        tableHeight += cellHeight
        print("packageTableView :\(tableHeight)")

        self.packageTableView.snp.updateConstraints({ make in
            make.height.equalTo(tableHeight)
        })
        packageTableView.reloadData()
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
    }
}






extension MyTripPackageViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func addNewData() {
        tableTempData.append(PackageCellData(title: "가짜 보조배터리", icon: UIImage(systemName: "battery.100"), isExpanded: false))
        self.adjustContentViewHeight()
        
//        let bottomSheetVC = MakePackageViewController()
//        bottomSheetVC.modalPresentationStyle = .pageSheet
//        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    private func toggleCellExpansion(at indexPath: IndexPath) {
        // 확장 상태 토글
        let wasExpanded = tableTempData[indexPath.row].isExpanded
        tableTempData[indexPath.row].isExpanded.toggle()
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // 테이블 뷰 높이 업데이트
            self.packageTableView.beginUpdates()
            self.packageTableView.endUpdates()
            
            // 셀 내부 콘텐츠 애니메이션 동기화
            if let cell = self.packageTableView.cellForRow(at: indexPath) as? PackageTableViewCell {
                cell.animateExpansion(isExpanded: self.tableTempData[indexPath.row].isExpanded)
            }

            var tableHeight: CGFloat = 0.0
            
            for i in 0..<self.tableTempData.count {
                if self.tableTempData[i].isExpanded {
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
        
        if !wasExpanded{
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height)
            scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTempData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifier, for: indexPath) as! PackageTableViewCell
        
        if tableTempData.count == indexPath.row {
            cell.configure(with: "", icon: UIImage(systemName: "circle.dotted")!, isExpanded: false)
            cell.onInfoButtonTapped = nil
            cell.contentView.backgroundColor = .lightGray
            return cell
        }
        
        let item = tableTempData[indexPath.row]
        cell.configure(with: item.title, icon: item.icon, isExpanded: item.isExpanded)
        cell.contentView.backgroundColor = .lightGray
        cell.onInfoButtonTapped = { [weak self] btn in
            self?.toggleCellExpansion(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 데이터 추가 셀에서만 터치 이벤트 처리
        if indexPath.row == tableTempData.count {
            addNewData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row == tableTempData.count {
            return nil // 데이터 추가 셀에는 스와이프 동작 비활성화
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (action, view, completionHandler) in
            // 데이터 삭제
            self?.tableTempData.remove(at: indexPath.row)
            // 테이블 뷰에서 셀 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // 높이 업데이트
//            self?.updateTableViewHeight()
            
            self?.adjustContentViewHeight()
            completionHandler(true)
        }
        
        // 삭제 버튼 커스터마이징 (선택 사항)
        deleteAction.backgroundColor = .systemOrange
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == tableTempData.count {
            return cellHeight
        }
        
        let item = tableTempData[indexPath.row]
        return item.isExpanded ? expandedCellHeight : cellHeight
    }
}
