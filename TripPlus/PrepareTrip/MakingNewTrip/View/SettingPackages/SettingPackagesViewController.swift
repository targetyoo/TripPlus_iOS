//
//  SettingPackagesViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/29/25.
//

import Foundation
import UIKit
import SnapKit


class SettingPackagesViewController: UIViewController{
    
    private var tableTempData: [PackageCellData] = [
        PackageCellData(title: "보조 배터리 1", icon: UIImage(systemName: "battery.100"), isExpanded: false),
        PackageCellData(title: "워터슈즈 1", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 2", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 3", icon: UIImage(systemName: "shoe.fill"), isExpanded: false),
        PackageCellData(title: "워터슈즈 4", icon: UIImage(systemName: "shoe.fill"), isExpanded: false)
    ]
    
    private let cellHeight: CGFloat = 65.0
    private let expandedCellHeight: CGFloat = 160.0 // 확장된 셀 높이
    
    private lazy var settingGuideTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black  //Temp
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)  //Temp
        label.text = "준비물 생성이 완료되었어요"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingGuideDescription: UILabel = {
        let label = UILabel()
        label.textColor = .gray //Temp
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium) //Temp
        label.numberOfLines = 0
        label.text = "여행 준비물은 여행 탭에서\n언제든 수정하고 추가할 수 있어요"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingGuideTitle, settingGuideDescription])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //    private lazy var scrollView: UIScrollView = {
    //        let scrollView = UIScrollView()
    //        scrollView.alwaysBounceVertical = true
    //        scrollView.showsVerticalScrollIndicator = false
    //        scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        return scrollView
    //    }()
    
    private lazy var settingPackageTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(PackageTableViewCell.self, forCellReuseIdentifier: PackageTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.separatorStyle = .none
        tableView.tintAdjustmentMode = .normal
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var makeNewMyTripBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        btn.setTitle("여행 생성하기", for: .normal)
        btn.snp.makeConstraints({ make in
            make.height.equalTo(50.0) //temp
        })
        btn.addTarget(self, action: #selector(makeNewMyTripBtnTapped), for: .touchUpInside)
        
        btn.layer.cornerRadius = 14.0 //temp
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    
    @objc private func makeNewMyTripBtnTapped() {
        let myTripPageVC = MyTripPageViewController()
        self.navigationController?.pushViewController(myTripPageVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationItem.title = "여행 만들기"
        setViews()
        //        updateTableViewHeight()
    }
    
    private func setViews(){
        [verticalStackView, settingPackageTableView, makeNewMyTripBtn].forEach({self.view.addSubview($0)})
        
        verticalStackView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15.0)
            make.leading.equalToSuperview().offset(15.0)
            make.height.equalTo(85.0)
        })
        
        makeNewMyTripBtn.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50.0)
        })
        
        //        scrollView.snp.makeConstraints({ make in
        //            make.top.equalTo(verticalStackView.snp.bottom).offset(25.0)
        //            make.leading.trailing.equalToSuperview()
        //
        //        })
        
        
        settingPackageTableView.snp.makeConstraints({ make in
            make.top.equalTo(verticalStackView.snp.bottom).offset(25.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            //            make.edges.equalToSuperview()
            //            make.height.equalToSuperview()
        })
    }
    
    // 테이블 뷰 높이를 동적으로 업데이트
    private func updateTableViewHeight() {
        //        let totalHeight = CGFloat(tableTempData.count) * cellHeight //cellHeight
        let totalHeight = tableTempData.reduce(0) { (result, item) in
            result + (item.isExpanded ? expandedCellHeight : cellHeight)
        }
        
        settingPackageTableView.snp.updateConstraints { make in
            make.height.equalTo(totalHeight + cellHeight)
        }
        //        scrollView.layoutIfNeeded()
        //        settingPackageTableView.reloadData()
    }
    
    //    private func toggleCellExpansion(at indexPath: IndexPath) {
    //        tableTempData[indexPath.row].isExpanded.toggle()
    //        settingPackageTableView.beginUpdates()
    //        settingPackageTableView.endUpdates()
    ////        settingPackageTableView.reloadRows(at: [indexPath], with: .automatic) // 셀 리로드 추가
    //        updateTableViewHeight()
    //    }
    //
    
    private func addNewData() {
        
        //        그리고 생성하는 cell 맨 위로 올려야 함
        
        let bottomSheetVC = AddNewPackageViewController()
        bottomSheetVC.modalPresentationStyle = .pageSheet
        present(bottomSheetVC, animated: true, completion: nil)
        
        
        //        test
        //        // 새로운 데이터 추가
        //        let newData = PackageCellData(title: "추가한 데이터 \(tableTempData.count + 1)", icon: UIImage(systemName: "battery.0"), isExpanded: false)
        //        tableTempData.append(newData)
        //
        //        // 테이블 뷰 업데이트
        //        let newIndexPath = IndexPath(row: tableTempData.count - 1, section: 0)
        //        settingPackageTableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    
    private func toggleCellExpansion(at indexPath: IndexPath) {
        // 확장 상태 토글
        let wasExpanded = tableTempData[indexPath.row].isExpanded
        tableTempData[indexPath.row].isExpanded.toggle()
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // 테이블 뷰 높이 업데이트
            self.settingPackageTableView.beginUpdates()
            self.settingPackageTableView.endUpdates()
            
            // 셀 내부 콘텐츠 애니메이션 동기화
            if let cell = self.settingPackageTableView.cellForRow(at: indexPath) as? PackageTableViewCell {
                cell.animateExpansion(isExpanded: self.tableTempData[indexPath.row].isExpanded)
            }
            
            self.settingPackageTableView.scrollToRow(at: indexPath, at: .none, animated: true)
            //            self.updateTableViewHeight()
        }, completion: nil)
    }
    
//    private func presentPopover(from button: UIButton) {
//        let popoverVC = PopoverViewController()
//        popoverVC.modalPresentationStyle = .popover
//        
//        // 팝오버 프레젠테이션 컨트롤러 설정
//        if let popoverController = popoverVC.popoverPresentationController {
//            popoverController.sourceView = button // 버튼을 기준으로 팝오버 표시
//            popoverController.sourceRect = button.bounds // 버튼의 bounds를 기준으로 위치 설정
//            popoverController.permittedArrowDirections = [.up, .down] // 화살표 방향 설정
//            popoverController.delegate = self // 델리게이트 설정
//        }
//        
//        present(popoverVC, animated: true, completion: nil)
//    }
}

extension SettingPackagesViewController: UIPopoverPresentationControllerDelegate {
    // 팝오버가 아이폰에서도 팝오버 스타일로 표시되도록 설정
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension SettingPackagesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTempData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackageTableViewCell.identifier, for: indexPath) as! PackageTableViewCell
        
        if tableTempData.count == indexPath.row {
            cell.configure(with: "", icon: UIImage(systemName: "circle.dotted")!, isExpanded: false)
            cell.onInfoButtonTapped = nil
            return cell
        }
        
        let item = tableTempData[indexPath.row]
        //        cell.configure(with: item.0, icon: item.1) //item.0 = 튜플의 첫 번째 요소, item.1 = 튜플의 두 번째 요소 ...
        cell.configure(with: item.title, icon: item.icon, isExpanded: item.isExpanded)
        cell.onInfoButtonTapped = { [weak self] btn in
            self?.toggleCellExpansion(at: indexPath)
            //            self?.presentPopover(from: btn)
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //            self?.updateTableViewHeight()
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

