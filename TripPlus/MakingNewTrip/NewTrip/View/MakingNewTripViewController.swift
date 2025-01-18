//
//  MakingNewTripViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/8/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class MakingNewTripViewController: UIViewController {
    var tripName = ""
    private var viewModel = MakingNewTripModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var makingNewTripView: MakingNewTripView = {
        let view = MakingNewTripView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("tripnName : \(tripName)")
        
        setupNavigationBar()
        bindViewModel()
        setView()
    }
    
    private func setView(){
        self.view.addSubview(makingNewTripView)
        makingNewTripView.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10.0)
            make.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    private func setupNavigationBar() {
        self.title = "여행 만들기"
        navigationController?.navigationBar.tintColor = .black

        
        // 왼쪽 버튼 생성
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back"), for: .normal) // SF Symbols에서 아이콘 사용
//        backButton.setTitle(" 이전", for: .normal) // 앞에 공백 추가
        backButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        // 오른쪽 버튼 설정
//        let rightButton = UIBarButtonItem(title: "1/n", style: .plain, target: nil, action: nil)
//        self.navigationItem.rightBarButtonItem = rightButton

        let addGuestButton = UIButton(type: .system)
        addGuestButton.isUserInteractionEnabled = false
        addGuestButton.setTitle("1/n", for: .normal) // 앞에 공백 추가
        addGuestButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        let rightButtonItem = UIBarButtonItem(customView: addGuestButton)
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        // 버튼 색상 및 폰트 설정
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont(name: "PRETENDARD-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
//        ]
        
//        backButton.setTitleTextAttributes(attributes, for: .normal)
//        rightButton.setTitleTextAttributes(attributes, for: .normal)
        
        
//        // Combine을 사용하여 버튼 클릭 이벤트 처리
//        backButton.publisher
//            .sink { [weak self] _ in
//                self?.viewModel.backButtonAction()
//            }
//            .store(in: &cancellables)
  
        backButton.publisher(for: .touchUpInside)
                 .sink { [weak self] _ in
                     self?.viewModel.backButtonAction() // ViewModel의 backButtonAction 호출
                 }
                 .store(in: &cancellables)
        
//        rightButton.publisher
//            .sink { [weak self] _ in
//                self?.viewModel.rightButtonAction()
//            }
//            .store(in: &cancellables)
        
        addGuestButton.publisher(for: .touchUpInside)
                 .sink { [weak self] _ in
                     self?.viewModel.rightButtonAction() // ViewModel의 backButtonAction 호출
                 }
                 .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        viewModel.backButtonTapped
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.rightButtonTapped
            .sink { _ in
                print("오른쪽 버튼 클릭됨")
            }
            .store(in: &cancellables)
    }
}
