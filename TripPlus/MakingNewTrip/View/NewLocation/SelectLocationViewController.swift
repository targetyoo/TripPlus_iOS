//
//  SelectLocationViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/18/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

protocol SelectLocationDelegate: AnyObject {
    func finishSelectLocations(selectedLocations: [String])
}

class SelectLocationViewController: UIViewController{
    var viewModel = MakingNewTripModel()
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: SelectLocationDelegate?
    
    private lazy var searchBar: SearchBarView = {
        let view = SearchBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 80.0)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 100.0, right: 0.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
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
        self.view.backgroundColor = .white
        
        [searchBar, selectedItemsView, locationCollectionView, completeBtn].forEach({ self.view.addSubview($0)})
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
            make.bottom.equalTo(locationCollectionView.snp.top)
            make.height.equalTo(0.0)
        })
        
        locationCollectionView.snp.makeConstraints({ make in
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
        navigationController?.navigationBar.tintColor = .black

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "back"), for: .normal) // SF Symbols에서 아이콘 사용
//        backButton.setTitle(" 이전", for: .normal) // 앞에 공백 추가
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
        
        viewModel.$selectedLocationItems
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.updateCollectionView(with: self.viewModel.selectedLocationItems)
                self.updateLocationCells()
                
                if self.viewModel.selectedLocationItems.count > 0{
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
                self.delegate?.finishSelectLocations(selectedLocations: viewModel.selectedLocationItems )
                //TODO: (도시 뿐만 아니라, 국가의 값까지?)
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func updateCollectionView(with items: [String]) {
        // LocationItem Added
        selectedItemsView.selectedItemsCollectionView.reloadData()
        
        UIView.animate(withDuration: 0.3) {
            self.selectedItemsView.snp.updateConstraints { make in
                make.height.equalTo(items.isEmpty ? 0 : 30) // 아이템이 없으면 높이를 0으로, 있으면 50으로
            }
            self.view.layoutIfNeeded() // 레이아웃 업데이트
        }
    }
    
    private func updateLocationCells() {
        // 모든 카테고리 셀을 업데이트
        for index in 0..<viewModel.locationItems.count {
            let indexPath = IndexPath(item: index, section: 0)
            if let cell = locationCollectionView.cellForItem(at: indexPath) as? LocationCollectionViewCell {
                let location = viewModel.locationItemKeys[index]
                let isSelected = viewModel.selectedLocationItems.contains(location)
                cell.selectBtn.setImage(UIImage(named: isSelected ? "checkCircle_checked" : "checkCircle"), for: .normal)
            }
        }
    }
}


extension SelectLocationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == locationCollectionView{
            return self.viewModel.locationItems.count
        }
        
        if collectionView == selectedItemsView.selectedItemsCollectionView{
            return self.viewModel.selectedLocationItems.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //TODO: Dictionary타입이라서, ViewController가 열릴 때 마다 배열의 순서가 뒤죽박죽임..
        
        // key: 도시, value : 국가
        let locationDictKey = viewModel.locationItemKeys[indexPath.row]
        guard let locationDictValue = viewModel.locationItems[locationDictKey] else { return UICollectionViewCell() }
        let isSelected = viewModel.selectedLocationItems.contains(locationDictKey)

        
        if collectionView == locationCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as? LocationCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(city: locationDictKey, nation: locationDictValue, onSelect: { [weak self] location in
                guard let self = self else { return }

                if viewModel.selectedLocationItems.contains(location){
                    self.viewModel.removeSelectedLocationElement(element: location)
                }else{
                    self.viewModel.addSelectedLocationElement(element: location)
                }
                print(self.viewModel.selectedLocationItems)
            })
            cell.selectBtn.setImage(UIImage(named: isSelected ? "checkCircle_checked" : "checkCircle"), for: .normal)

            return cell
        }
        
        if collectionView == selectedItemsView.selectedItemsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedItemsCollectionViewCell.identifier, for: indexPath) as? SelectedItemsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(itemName: self.viewModel.selectedLocationItems[indexPath.row]){ [weak self] location in
                guard let self = self else { return }
                self.viewModel.removeSelectedLocationElement(element: location)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if collectionView == selectedItemsView.selectedItemsCollectionView {
            // 일반 박스 셀: 텍스트 길이에 맞게 크기 조정
            let text = viewModel.selectedLocationItems[indexPath.row]
            let font = UIFont(name: "PRETENDARD-Regular", size: 16.0)!
            let width = self.getTextWidth(text: text, font: font, space: 35.0)
            print(width)
            
//            let textWidth = (text as NSString).boundingRect(
//                with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30),
//                options: [.usesLineFragmentOrigin, .usesFontLeading],
//                attributes: [.font: font],
//                context: nil
//            ).width
//            
////            여백 추가
//            let width = textWidth + 30 // 24(deleteBtn width) + 6(space )

            return CGSize(width: width, height: 30) // 높이는 고정
        } else {
           return CGSize(width: self.view.frame.width, height: 80.0)
        }
    }
}
