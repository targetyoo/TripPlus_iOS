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

extension MakingNewTripViewController: SelectCategoryDelegate {
    func finishSelectCategories(selectedCategories: [String]) {
        viewModel.selectedCategoryItems = selectedCategories // 선택된 카테고리 업데이트
        makingNewTripView.setCategoryCollectionView.reloadData() // 컬렉션 뷰 업데이트
        
        //collectionView height 업데이트
        if viewModel.selectedCategoryItems.count > 0 {
            let contentHeight =  self.makingNewTripView.setCategoryCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.makingNewTripView.setCategoryCollectionView.snp.updateConstraints { make in
                   make.height.equalTo(contentHeight) // 콘텐츠 높이에 맞게 업데이트
               }
        }else{
            self.makingNewTripView.setCategoryCollectionView.snp.updateConstraints { make in
                make.height.equalTo(30.0)
            }
        }
    }
}

extension MakingNewTripViewController: SelectLocationDelegate {
    func finishSelectLocations(selectedLocations: [String]) {
        viewModel.selectedLocationItems = selectedLocations // 선택된 카테고리 업데이트
        makingNewTripView.setLocationCollectionView.reloadData() // 컬렉션 뷰 업데이트
        
        //collectionView height 업데이트
        if viewModel.selectedLocationItems.count > 0 {
            let contentHeight =  self.makingNewTripView.setLocationCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.makingNewTripView.setLocationCollectionView.snp.updateConstraints { make in
                   make.height.equalTo(contentHeight) // 콘텐츠 높이에 맞게 업데이트
               }
        }else{
            self.makingNewTripView.setLocationCollectionView.snp.updateConstraints { make in
                make.height.equalTo(30.0)
            }
        }
    }
}

class MakingNewTripViewController: UIViewController {
    var tripName = ""
    private var viewModel = MakingNewTripModel()
    private var cancellables = Set<AnyCancellable>()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setupNavigationBar()
        bindViewModel()
    }
    
    private func setView(){
        self.view.backgroundColor = .white
        
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

        makingNewTripView.setLocationCollectionView.delegate = self
        makingNewTripView.setLocationCollectionView.dataSource = self
//        makingNewTripView.setDateButton
        
        
        makingNewTripView.setCategoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(30.0)
        }
        makingNewTripView.setLocationCollectionView.snp.makeConstraints{ make in
            make.height.equalTo(30.0)
        }

    }
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // 원하는 색상
              .font: UIFont(name: "PRETENDARD-SemiBold", size: 16.0)! // 원하는 폰트와 크기
          ]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "여행 만들기"
        
        // 왼쪽 버튼 생성
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back"), for: .normal) // SF Symbols에서 아이콘 사용
        backButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        // 오른쪽 버튼 설정
        let addGuestButton = UIButton(type: .system)
        addGuestButton.isUserInteractionEnabled = false
        addGuestButton.setTitle("1/n", for: .normal) // 앞에 공백 추가
        addGuestButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        let rightButtonItem = UIBarButtonItem(customView: addGuestButton)
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        backButton.publisher(for: .touchUpInside)
                 .sink { [weak self] _ in
                     self?.viewModel.backButtonAction()
                 }
                 .store(in: &cancellables)
        
//        addGuestButton.publisher(for: .touchUpInside)
//                 .sink { [weak self] _ in
//                     self?.viewModel.rightButtonAction()
//                 }
//                 .store(in: &cancellables)
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
        
        
        viewModel.$selectedCategoryItems // $ 기호는 @Published 속성의 퍼블리셔에 접근하기 위해 사용됩
            .receive(on: RunLoop.main) // 퍼블리셔가 발행하는 값을 메인 스레드에서 수신(UI 업데이트)
            .sink { [weak self] items in
                guard let self = self else { return }
                makingNewTripView.setCategoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$selectedLocationItems
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                makingNewTripView.setLocationCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        
        viewModel.openAddCategoryButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                let selectCategoryVC = SelectCategoryViewController()
                selectCategoryVC.delegate = self
                selectCategoryVC.viewModel.selectedCategoryItems = self.viewModel.selectedCategoryItems
                self.navigationController?.pushViewController(selectCategoryVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.openAddLocationButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                let selectLocationVC = SelectLocationViewController()
                selectLocationVC.delegate = self
                selectLocationVC.viewModel.selectedLocationItems = self.viewModel.selectedLocationItems
                self.navigationController?.pushViewController(selectLocationVC, animated: true)
            }
            .store(in: &cancellables)
    }

}



extension MakingNewTripViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            return viewModel.selectedCategoryItems.count + 1
        }
        
        if collectionView == makingNewTripView.setLocationCollectionView{
            return viewModel.selectedLocationItems.count + 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            if indexPath.row < viewModel.selectedCategoryItems.count {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightAlignedCollectionViewCell.identifier, for: indexPath) as? RightAlignedCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.configure(title: viewModel.selectedCategoryItems[indexPath.row])
                return cell
                
            }else{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCell.identifier, for: indexPath) as? AddItemCell else{
                    return UICollectionViewCell()
                }
                
                cell.configure(onSelect: {
                    self.viewModel.openAddCategoryVC()
                })
                
                return cell
            }
        }
        
        if collectionView == makingNewTripView.setLocationCollectionView{
            if indexPath.row < viewModel.selectedLocationItems.count{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightAlignedCollectionViewCell.identifier, for: indexPath) as? RightAlignedCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.configure(title: viewModel.selectedLocationItems[indexPath.row])
                return cell
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCell.identifier, for: indexPath) as? AddItemCell else{
                    return UICollectionViewCell()
                }
                
                cell.configure(onSelect: {
                    self.viewModel.openAddLocationVC()
                })
                //                cell.addBtn.publisher(for: .touchUpInside)
                //                    .sink { [weak self] _ in
                //                        self?.viewModel.openAddLocationVC()
                //                    }
                //                    .store(in: &cancellables)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont(name: "PRETENDARD-Regular", size: 16.0)!
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            if indexPath.row < viewModel.selectedCategoryItems.count {
                let text = viewModel.selectedCategoryItems[indexPath.row]
                let width = self.getTextWidth(text: text, font: font, space: 30.0)
                return CGSize(width: width, height: 30) // 높이는 고정
            }else{
                return CGSize(width: 24, height: 30)
            }
        }
        
        if collectionView == makingNewTripView.setLocationCollectionView{
            if indexPath.row < viewModel.selectedLocationItems.count {
                let text = viewModel.selectedLocationItems[indexPath.row]
                let width = self.getTextWidth(text: text, font: font, space: 30.0)
                // 텍스트의 실제 너비 계산
                //            let textWidth = (text as NSString).boundingRect(
                //                with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30),
                //                options: [.usesLineFragmentOrigin, .usesFontLeading],
                //                attributes: [.font: font!],
                //                context: nil
                //            ).width
                
                // 여백 추가
                //            let width = textWidth + 30 // 24(deleteBtn width) + 6(space )
                return CGSize(width: width, height: 30) // 높이는 고정
            } else {
                // + 버튼 셀: 고정된 크기
                return CGSize(width: 24, height: 30)
            }
        }
        
        return .zero
    }
}


