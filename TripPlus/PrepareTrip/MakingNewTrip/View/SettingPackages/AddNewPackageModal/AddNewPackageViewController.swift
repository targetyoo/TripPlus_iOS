//
//  AddNewPackageViewController.swift
//  TripPlus
//
//  Created by 유대상 on 5/30/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class AddNewPackageViewController: UIViewController {
    let viewModel = MakingNewPackageModel()
    let navigationVM = NavigationViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var viewControllerTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 준비물"
        label.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.snp.makeConstraints({make in
            make.height.equalTo(45.0)
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var newPackageBox: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.0
        view.backgroundColor = UIColor(named: "grayD")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newPackageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = PaleteIconData.icons[0]
        imageView.tintColor = PaleteColorData.colors[0]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var newPackageNameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.0
        view.backgroundColor = UIColor(named: "grayC")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newPackageName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "준비물 이름"
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var colorPalete: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40.0, height: 40.0)
        
        layout.minimumLineSpacing = 20.0 // 셀 간 세로 간격
        layout.minimumInteritemSpacing = 20.0 // 셀 간 가로 간격
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaleteCollectionViewCell.self, forCellWithReuseIdentifier: PaleteCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "grayD")
        collectionView.layer.cornerRadius = 7.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var iconPalete: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40.0, height: 40.0)
        
        layout.minimumLineSpacing = 20.0 // 셀 간 세로 간격
        layout.minimumInteritemSpacing = 20.0 // 셀 간 가로 간격
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) // 섹션 여백
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PaleteCollectionViewCell.self, forCellWithReuseIdentifier: PaleteCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "grayD")
        collectionView.layer.cornerRadius = 7.0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.configureSheetPresentation()
        self.setBinding()
    }

    private func setViews() {
        self.view.backgroundColor = UIColor(named: "grayC")
        
        
        [viewControllerTitle, backButton, confirmButton, newPackageBox, colorPalete, iconPalete].forEach({self.view.addSubview($0)})
        
        [newPackageIcon, newPackageNameView].forEach({self.newPackageBox.addSubview($0)})
        
        newPackageNameView.addSubview(newPackageName)
        
        viewControllerTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(25.0)
            make.centerX.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.top)
            make.leading.equalToSuperview().offset(15.0)
        })
        
        confirmButton.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.top)
            make.trailing.equalToSuperview().offset(-15.0)
        })
        
        newPackageBox.snp.makeConstraints({ make in
            make.top.equalTo(viewControllerTitle.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(125.0)
        })
        
        newPackageIcon.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(10.0)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(36.0)
        })
        
        newPackageNameView.snp.makeConstraints({ make in
            make.top.equalTo(newPackageIcon.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().offset(-10.0)
            make.height.equalTo(45.0)
        })
        
        newPackageName.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
        
        colorPalete.snp.makeConstraints({ make in
            make.top.equalTo(newPackageBox.snp.bottom).offset(15.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(120.0)
        })
          
        iconPalete.snp.makeConstraints({ make in
            make.top.equalTo(colorPalete.snp.bottom).offset(15.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
            make.height.equalTo(360.0)
        })
    }
    
    private func setBinding(){
        confirmButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.completeBtnAction()
            }
            .store(in: &cancellables)
        backButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.backButtonAction()
            }
            .store(in: &cancellables)
        
        navigationVM.backButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        navigationVM.completeButtonTapped
            .sink{ [weak self] in
                guard let self = self else { return }
                print("new Package : \(viewModel.$packageName), \(viewModel.$packageIcon), \(viewModel.$packageColor)")
                self.dismiss(animated: true)
            }
            .store(in: &cancellables)
        
        newPackageName.publisher(for: .editingChanged)
            .sink{ [weak self] _ in
                self?.viewModel.writingTitle(self?.newPackageName.text ?? "")
            }
            .store(in: &cancellables)
        
        viewModel.$packageIcon
            .receive(on: RunLoop.main)
            .sink { icon in
                print(icon)
                self.newPackageIcon.image = icon
            }
            .store(in: &cancellables)
        
        viewModel.$packageColor
            .receive(on: RunLoop.main)
            .sink { color in
                self.newPackageIcon.tintColor = color
            }
            .store(in: &cancellables)
    }
    
    
    private func configureSheetPresentation() {
        // 바텀 시트 설정
        if let sheet = sheetPresentationController {
            // 바텀 시트 크기 설정 (medium, large 등)
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.7 // 화면 높이 30%
            }, .large()]
            // 드래그 가능한 상단 바 표시
            sheet.prefersGrabberVisible = true
            // 모달 뒤의 뷰 흐림 효과
            sheet.prefersEdgeAttachedInCompactHeight = true
            // 바텀 시트가 화면 전체를 덮지 않도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
    }
}

extension AddNewPackageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorPalete{
            return PaleteColorData.colors.count
        }else if collectionView == iconPalete{
            return PaleteIconData.icons.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaleteCollectionViewCell.identifier, for: indexPath) as? PaleteCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == iconPalete{
            cell.configure(paleteColor: nil, paleteIcon: PaleteIconData.icons[indexPath.row], isIconPalete: true, onSelect: {
                self.viewModel.selectPackageIcon(PaleteIconData.icons[indexPath.row] ?? UIImage())
            })
        }else if collectionView == colorPalete{
            cell.configure(paleteColor: PaleteColorData.colors[indexPath.row], paleteIcon: nil, isIconPalete: false, onSelect: {
                self.viewModel.selectPackageColor(PaleteColorData.colors[indexPath.row] ?? UIColor())
            })
        }
        return cell
    }
}


extension AddNewPackageViewController: UITextFieldDelegate {
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
//    func makeUIViewController(context: Context) -> AddNewPackageViewController {
//        return AddNewPackageViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: AddNewPackageViewController, context: Context) {
//        // 필요 시 업데이트 로직 추가
//    }
//}
//
//// 3. SwiftUI Preview 제공
//#Preview {
//    MyViewControllerRepresentable()
//}
