//
//  SelectCategoryViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/28/25.
//

import Foundation
import SnapKit
import Combine
import UIKit

protocol SelectCategoryDelegate: AnyObject {
    func finishSelectCategories(selectedCategories: [String])
}

class SelectCategoryViewController: UIViewController {
    var viewModel = MakingNewTripModel()
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: SelectCategoryDelegate?

    
    private lazy var searchBar: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 80.0)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100.0, right: 0.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var selectedItemsView: SelectedItemsView = {
        let view = SelectedItemsView()
        view.selectedItemsCollectionView.delegate = self
        view.selectedItemsCollectionView.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var completeBtn: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 14.0
        btn.clipsToBounds = false
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        btn.backgroundColor = UIColor(named: "grayC")
        btn.snp.makeConstraints({ make in
            make.height.equalTo(50.0)
        })
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 12
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
        setViews()
        setupNavigationBar()
        bindViewModel()
    }
    
    private func setViews(){
        [searchBar, selectedItemsView, categoryCollectionView, completeBtn].forEach({ self.view.addSubview($0)})
        self.view.bringSubviewToFront(completeBtn)
        
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(80.0)
        })
                
        selectedItemsView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.snp.bottom).offset(15.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(categoryCollectionView.snp.top)
            make.height.equalTo(0.0)
        })
        
        categoryCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(selectedItemsView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        completeBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        searchBar.configure(type: .TYPE_DESTINATION)
        
        completeBtn.publisher(for: .touchUpInside)
            .sink { _ in
                self.viewModel.completeBtnAction()
            }
            .store(in: &cancellables)
    }
    
    private func setupNavigationBar(){
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back"), for: .normal) // SF Symbols에서 아이콘 사용
        backButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        backButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.backButtonAction() // ViewModel의 backButtonAction 호출
            }
            .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        viewModel.backButtonTapped
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
 
        viewModel.$selectedCategoryItems
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.updateCollectionView(with: self.viewModel.selectedCategoryItems)
                self.updateCategoryCells()
                
                if self.viewModel.selectedCategoryItems.count > 0{
                    completeBtn.backgroundColor = UIColor(named: "tripGreen")
                    completeBtn.setTitleColor(UIColor(named: "grayD"), for: .normal)
                    completeBtn.isUserInteractionEnabled = true
                }else{
                    completeBtn.setTitleColor(UIColor(named: "grayA"), for: .normal)
                    completeBtn.backgroundColor = UIColor(named: "grayC")
                    completeBtn.isUserInteractionEnabled = false
                }
            }
            .store(in: &cancellables)
        
        viewModel.completeButtonTapped
            .sink { [weak self] in
                guard let self = self else { return }
                self.delegate?.finishSelectCategories(selectedCategories: viewModel.selectedCategoryItems )
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func updateCollectionView(with items: [String]) {
        // CategoryItem Added
        selectedItemsView.selectedItemsCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.selectedItemsView.snp.updateConstraints { make in
                make.height.equalTo(items.isEmpty ? 0 : 30) // 아이템이 없으면 높이를 0으로, 있으면 50으로
            }
            self.view.layoutIfNeeded() // 레이아웃 업데이트
        }
    }
    
    private func updateCategoryCells() {
        // 모든 카테고리 셀을 업데이트
        for index in 0..<viewModel.categoryItems.count {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = categoryCollectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                let category = viewModel.categoryItems[index]
                let isSelected = viewModel.selectedCategoryItems.contains(category)
                cell.selectBtn.setImage(UIImage(named: isSelected ? "checkCircle_checked" : "checkCircle"), for: .normal)
            }
        }
    }
}


extension SelectCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return self.viewModel.categoryItems.count
        }
        
        if collectionView == selectedItemsView.selectedItemsCollectionView{
            return self.viewModel.selectedCategoryItems.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category = viewModel.categoryItems[indexPath.row]
        let isSelected = viewModel.selectedCategoryItems.contains(category)
        
        if collectionView == categoryCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(category: self.viewModel.categoryItems[indexPath.row]){ [weak self] category in
                guard let self = self else { return }
                                
                if viewModel.selectedCategoryItems.contains(category){
                    self.viewModel.removeSelectedCategoryElement(element: category)
                }else{
                    self.viewModel.addSelectedCategoryElement(element: category)
                }
                print(self.viewModel.selectedCategoryItems)
            }
            return cell
        }
        
        if collectionView == selectedItemsView.selectedItemsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.identifier, for: indexPath) as? SelectedItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(itemName: self.viewModel.selectedCategoryItems[indexPath.row]){ [weak self] category in
                guard let self = self else { return }
                self.viewModel.removeSelectedCategoryElement(element: category)
            }

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView == selectedItemsView.selectedItemsCollectionView {
            // 일반 박스 셀: 텍스트 길이에 맞게 크기 조정
            let text = viewModel.selectedCategoryItems[indexPath.row]
            let font = UIFont(name: "PRETENDARD-Regular", size: 16.0)!
 
            let width = self.getTextWidth(text: text, font: font, space: 35.0)

            return CGSize(width: width, height: 30) // 높이는 고정
        } else {
            // + 버튼 셀: 고정된 크기
           return CGSize(width: self.view.frame.width, height: 80.0)
        }
    }
}
