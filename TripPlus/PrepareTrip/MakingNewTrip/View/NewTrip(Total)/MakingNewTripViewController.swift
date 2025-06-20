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
        makingCategoryVM.selectedCategoryItems = selectedCategories // 선택된 카테고리 업데이트
        makingNewTripView.setCategoryCollectionView.reloadData() // 컬렉션 뷰 업데이트
        
        //collectionView height 업데이트
        if makingCategoryVM.selectedCategoryItems.count > 0 {
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
        makingLocationVM.selectedLocationItems = selectedLocations // 선택된 카테고리 업데이트
        makingNewTripView.setLocationCollectionView.reloadData() // 컬렉션 뷰 업데이트
        
        //collectionView height 업데이트
        if makingLocationVM.selectedLocationItems.count > 0 {
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
    private var navigationVM = NavigationViewModel()
    private var makingCategoryVM = MakingCategoryViewModel()
    private var makingLocationVM = MakingLocationViewModel()
    private var cancellables = Set<AnyCancellable>()
        
    private lazy var makingNewTripView: MakingNewTripView = {
        let view = MakingNewTripView()
        return view
    }()
    
    private var newTripProgressView: NewTripProgressView = {
        let view = NewTripProgressView()
        view.snp.makeConstraints({ make in
            make.height.equalTo(55.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var createSuppliesBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = DesignSystem.Button.cornerRadius
        btn.setTitle("준비물 생성하기", for: .normal)
        btn.setTitleColor(UIColor(named: "grayB"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16.0)
        btn.backgroundColor = UIColor(named: "grayC")
        btn.snp.makeConstraints({ make in
            make.height.equalTo(DesignSystem.Button.height)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.enableBtn()
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
        setupTabGesture()
    }
    
    private func setView(){
        self.view.backgroundColor = .white
        
        [makingNewTripView, newTripProgressView, createSuppliesBtn].forEach({self.view.addSubview($0)})
        
        makingNewTripView.snp.makeConstraints({ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10.0)
            make.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        })
        makingNewTripView.tripTitleTextView.delegate = self
        makingNewTripView.setCategoryCollectionView.delegate = self
        makingNewTripView.setCategoryCollectionView.dataSource = self
        makingNewTripView.setLocationCollectionView.delegate = self
        makingNewTripView.setLocationCollectionView.dataSource = self
        
        createSuppliesBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        newTripProgressView.snp.makeConstraints({ make in
            make.bottom.equalTo(createSuppliesBtn.snp.top)
            make.leading.equalTo(createSuppliesBtn.snp.leading)
            make.trailing.equalTo(createSuppliesBtn.snp.trailing)
        })
        newTripProgressView.configure(currentProgress: 1)
        
        
        makingNewTripView.setCategoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(30.0)
        }
        makingNewTripView.setLocationCollectionView.snp.makeConstraints{ make in
            make.height.equalTo(30.0)
        }
        
        makingNewTripView.setDateButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.openAddDateVC()
            }
            .store(in: &cancellables)
        
        createSuppliesBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.completeBtnAction()
            }
            .store(in: &cancellables)
        
        makingNewTripView.tripTitleTextView.publisher(for: .editingChanged)
            .sink{ [weak self] _ in
                self?.viewModel.writingTitle(self?.makingNewTripView.tripTitleTextView.text ?? "")
            }
            .store(in: &cancellables)
    
        //Label은 UIControl이 없으므로, TabGestureRecognizer를 구현하여 연결
        makingNewTripView.lessLabelTGR.tapPublisher
            .sink{ [weak self] _ in
                self?.viewModel.selectLess()
            }
            .store(in: &cancellables)
        
        makingNewTripView.normalLabelTGR.tapPublisher
            .sink{ [weak self] _ in
                self?.viewModel.selectNormal()
            }
            .store(in: &cancellables)
        
        makingNewTripView.moreLabelTGR.tapPublisher
            .sink{ [weak self] _ in
                self?.viewModel.selectMore()
            }
            .store(in: &cancellables)
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
//        let addGuestButton = UIButton(type: .system)
//        addGuestButton.isUserInteractionEnabled = false
//        addGuestButton.setTitle("1/n", for: .normal) // 앞에 공백 추가
//        addGuestButton.titleLabel?.font = UIFont(name: "PRETENDARD-Regular", size: 16.0)
//        let rightButtonItem = UIBarButtonItem(customView: addGuestButton)
//        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        backButton.publisher(for: .touchUpInside)
                 .sink { [weak self] _ in
                     self?.navigationVM.backButtonAction()
                 }
                 .store(in: &cancellables)
        
//        addGuestButton.publisher(for: .touchUpInside)
//                 .sink { [weak self] _ in
//                     self?.viewModel.rightButtonAction()
//                 }
//                 .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        
        makingCategoryVM.$selectedCategoryItems // $ 기호는 @Published 속성의 퍼블리셔에 접근하기 위해 사용됩
            .receive(on: RunLoop.main) // 퍼블리셔가 발행하는 값을 메인 스레드에서 수신(UI 업데이트)
            .sink { [weak self] items in
                guard let self = self else { return }
                makingNewTripView.setCategoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        makingLocationVM.$selectedLocationItems
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
                selectCategoryVC.viewModel.selectedCategoryItems = self.makingCategoryVM.selectedCategoryItems
                self.navigationController?.pushViewController(selectCategoryVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.openAddLocationButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                let selectLocationVC = SelectLocationViewController()
                selectLocationVC.delegate = self
                selectLocationVC.viewModel.selectedLocationItems = self.makingLocationVM.selectedLocationItems
                self.navigationController?.pushViewController(selectLocationVC, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.openAddDateButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                let selectDateVC = SelectDateViewController()
                selectDateVC.modalPresentationStyle = .overFullScreen
                selectDateVC.modalTransitionStyle = .crossDissolve
                self.present(selectDateVC, animated: true, completion: nil)
            }
            .store(in: &cancellables)
        
        navigationVM.completeButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                self.createSuppliesBtn.isEnabled = false
                // 준비물 생성 중 페이지로 이동
                let preparingPackagesVC = PreparingPackagesViewController()
                preparingPackagesVC.modalPresentationStyle = .fullScreen
                preparingPackagesVC.viewModel.preparingPackageFinished
                    .sink{ [weak self] _packages in
                        let settingPackagesVC = SettingPackagesViewController()
                        settingPackagesVC.packages = _packages
                        self?.navigationController?.pushViewController(settingPackagesVC, animated: true)
                    }
                    .store(in: &cancellables)
                //preparingPackagesVC.준비물 준비에 필요한 데이터들 전달
                present(preparingPackagesVC, animated: true, completion: nil)
            }
            .store(in: &cancellables)
        
        navigationVM.backButtonTapped
            .sink { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
        
        
        
        viewModel.lessTabbed
            .receive(on: RunLoop.main)
            .sink{ [weak self] in
                self?.makingNewTripView.lessLabel.backgroundColor = UIColor(named: "tripGreen")
                self?.makingNewTripView.lessLabel.textColor = UIColor(named: "grayC")
                self?.makingNewTripView.normalLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.normalLabel.textColor = UIColor(named: "grayA")
                self?.makingNewTripView.moreLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.moreLabel.textColor = UIColor(named: "grayA")
            }
            .store(in: &cancellables)
        
        viewModel.normalTabbed
            .receive(on: RunLoop.main)
            .sink{ [weak self] in
                self?.makingNewTripView.lessLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.lessLabel.textColor = UIColor(named: "grayA")
                self?.makingNewTripView.normalLabel.backgroundColor = UIColor(named: "tripGreen")
                self?.makingNewTripView.normalLabel.textColor = UIColor(named: "grayC")
                self?.makingNewTripView.moreLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.moreLabel.textColor = UIColor(named: "grayA")
            }
            .store(in: &cancellables)
        
        viewModel.moreTabbed
            .receive(on: RunLoop.main)
            .sink{ [weak self] in
                self?.makingNewTripView.lessLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.lessLabel.textColor = UIColor(named: "grayA")
                self?.makingNewTripView.normalLabel.backgroundColor = UIColor(named: "grayC")
                self?.makingNewTripView.normalLabel.textColor = UIColor(named: "grayA")
                self?.makingNewTripView.moreLabel.backgroundColor = UIColor(named: "tripGreen")
                self?.makingNewTripView.moreLabel.textColor = UIColor(named: "grayC")
            }
            .store(in: &cancellables)
    }

    private func enableBtn(){
        //TODO: 여행을 등록할 Data가 있으면 Coloring, enable
        self.createSuppliesBtn.isEnabled = true
    }
}



extension MakingNewTripViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            return makingCategoryVM.selectedCategoryItems.count + 1
        }
        
        if collectionView == makingNewTripView.setLocationCollectionView{
            return makingLocationVM.selectedLocationItems.count + 1
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            if indexPath.row < makingCategoryVM.selectedCategoryItems.count {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightAlignedCollectionViewCell.identifier, for: indexPath) as? RightAlignedCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.configure(title: makingCategoryVM.selectedCategoryItems[indexPath.row])
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
            if indexPath.row < makingLocationVM.selectedLocationItems.count{
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightAlignedCollectionViewCell.identifier, for: indexPath) as? RightAlignedCollectionViewCell else{
                    return UICollectionViewCell()
                }
                cell.configure(title: makingLocationVM.selectedLocationItems[indexPath.row])
                return cell
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCell.identifier, for: indexPath) as? AddItemCell else{
                    return UICollectionViewCell()
                }
                
                cell.configure(onSelect: {
                    self.viewModel.openAddLocationVC()
                })
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont(name: "PRETENDARD-Regular", size: 16.0)!
        
        if collectionView == makingNewTripView.setCategoryCollectionView{
            if indexPath.row < makingCategoryVM.selectedCategoryItems.count {
                let text = makingCategoryVM.selectedCategoryItems[indexPath.row]
                let width = self.getTextWidth(text: text, font: font, space: 30.0)
                return CGSize(width: width + 10, height: 30) // 높이는 고정
            }else{
                return CGSize(width: 24, height: 30)
            }
        }
        
        if collectionView == makingNewTripView.setLocationCollectionView{
            if indexPath.row < makingLocationVM.selectedLocationItems.count {
                let text = makingLocationVM.selectedLocationItems[indexPath.row]
                let width = self.getTextWidth(text: text, font: font, space: 30.0)
                return CGSize(width: width + 10, height: 30) // 높이는 고정
            } else {
                // + 버튼 셀: 고정된 크기
                return CGSize(width: 24, height: 30)
            }
        }
        
        return .zero
    }
}

extension MakingNewTripViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 여행 제목 20글자 제한
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }
    
    private func setupTabGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dissmissKeyboard(){
        view.endEditing(true)
    }
}


//struct MyViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> MakingNewTripViewController {
//        return MakingNewTripViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: MakingNewTripViewController, context: Context) {
//        // 필요 시 업데이트 로직 추가
//    }
//}
//
//// 3. SwiftUI Preview 제공
//#Preview {
//    MyViewControllerRepresentable()
//}
