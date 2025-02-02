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
    
    var items: [String] = ["코타키나발루", "스페인", "독일", "북한"] //tem
    
    private lazy var makingNewTripView: MakingNewTripView = {
        let view = MakingNewTripView()
        return view
    }()
    
    private lazy var createSuppliesBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 14.0
        btn.setTitle("준비물 생성하기", for: .normal)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        btn.backgroundColor = UIColor(named: "grayC")
        btn.snp.makeConstraints({ make in
            make.height.equalTo(50.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("tripnName : \(tripName)")
        
        setupNavigationBar()
        setView()
        bindViewModel()
    }
    
    private func setView(){
        [makingNewTripView, createSuppliesBtn].forEach({self.view.addSubview($0)})
        
        makingNewTripView.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10.0)
            make.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        })
        
        createSuppliesBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        makingNewTripView.setCategoryCollectionView.delegate = self
        makingNewTripView.setCategoryCollectionView.dataSource = self

        makingNewTripView.setlocationCollectionView.delegate = self
        makingNewTripView.setlocationCollectionView.dataSource = self
//        makingNewTripView.setDateButton
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
        
        
        viewModel.addCategoryButtonTapped
            .sink{ [weak self] in
//                let selectCategoryVC = SelectCategoryViewController()
//                self?.navigationController?.pushViewController(selectCategoryVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.addLocationButtonTapped
            .sink{ [weak self] in
                let selectLocationVC = SelectLocationViewController()
                self?.navigationController?.pushViewController(selectLocationVC, animated: true)
            }
            .store(in: &cancellables)
    }

}



extension MakingNewTripViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < items.count {
            // 일반 아이템 셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightAlignedCollectionViewCell.identifier, for: indexPath) as? RightAlignedCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.configure(title: items[indexPath.row])
            return cell
        } else {
            // "+" 버튼 셀
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCell.identifier, for: indexPath) as? AddItemCell else{
                return UICollectionViewCell()
            }
            
            if collectionView == makingNewTripView.setCategoryCollectionView {
                cell.addBtn.publisher(for: .touchUpInside)
                    .sink { [weak self] _ in
                        self?.viewModel.addCategoryAction()
                    }
                    .store(in: &cancellables)
            }else{
                cell.addBtn.publisher(for: .touchUpInside)
                    .sink { [weak self] _ in
                        self?.viewModel.addLocationAction()
                    }
                    .store(in: &cancellables)
            }
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < items.count {
            // 일반 박스 셀: 텍스트 길이에 맞게 크기 조정
            let text = items[indexPath.row]
            let font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
            
            // 텍스트의 실제 너비 계산
            let textWidth = (text as NSString).boundingRect(
                with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [.font: font!],
                context: nil
            ).width

            // 여백 추가
            let width = textWidth + 30 // 24(deleteBtn width) + 6(space )
            return CGSize(width: width, height: 30) // 높이는 고정
        } else {
            // + 버튼 셀: 고정된 크기
            return CGSize(width: 24, height: 30)
        }
    }
}
