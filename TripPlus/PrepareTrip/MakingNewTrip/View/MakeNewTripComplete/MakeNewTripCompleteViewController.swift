//
//  MakeNewTripCompleteViewController.swift
//  TripPlus
//
//  Created by andev on 6/8/25.
//

import Foundation
import UIKit
import SnapKit
import Combine

class MakeNewTripCompleteViewController: UIViewController{
    private var navigationVM = NavigationViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text = "여행 만들기"
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var completeIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "luggage-43")
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor(named: "tripGreen")
        view.snp.makeConstraints({make in
            make.width.height.equalTo(56.0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tripNameLabel: UILabel = {
        let label = UILabel()
        label.text = """
"여행 제목"
"""
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createTripNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "여행이 생성되었어요!"
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inviteCompanionBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "grayC")
        btn.setTitle("동행자 초대하기", for: .normal)
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.setImage(UIImage(named: "copyLink"), for: .normal)
        btn.tintColor = UIColor(named: "grayA")
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.layer.cornerRadius = 14.0
        btn.semanticContentAttribute = .forceRightToLeft
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        btn.snp.makeConstraints({ make in
            make.width.equalTo(160.0)
            make.height.equalTo(35.0)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var confirmBtn: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor(named: "tripGreen")
        btn.setTitle("확인", for: .normal)
        btn.layer.cornerRadius = DesignSystem.Button.cornerRadius
        btn.setTitleColor(UIColor(named: "grayD"), for: .normal)
        btn.snp.makeConstraints({ make in
            make.height.equalTo(DesignSystem.Button.height)
        })
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //Companion Mode
    private lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "backArrow"), for: .normal)
        btn.tintColor = UIColor(named: "grayA")
        btn.setTitle("이전", for: .normal)
        btn.setTitleColor(UIColor(named: "grayA"), for: .normal)
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var companionIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "companion")
        imgView.snp.makeConstraints({ make in
            make.width.height.equalTo(18.0)
        })
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var companionName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "grayA")
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.text = "사용자1, 사용자2"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [companionIcon, companionName])
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        stackView.distribution = .equalSpacing
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        triggerHaptic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        bindViewModel()
    }
    
    private func setViews(){
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.view.backgroundColor = UIColor(named: "grayD")
        
        [viewTitle, completeIcon, tripNameLabel, createTripNoticeLabel, inviteCompanionBtn, confirmBtn].forEach({self.view.addSubview($0)})
        
        viewTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(15.0)
            make.centerX.equalToSuperview()
        })
        
        inviteCompanionBtn.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
        
        createTripNoticeLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(inviteCompanionBtn.snp.top).offset(-20.0)
            make.centerX.equalToSuperview()
        })
        
        tripNameLabel.snp.makeConstraints({ make in
            make.bottom.equalTo(createTripNoticeLabel.snp.top)
            make.leading.equalToSuperview().offset(50.0)
            make.trailing.equalToSuperview().offset(-50.0)
        })
        
        completeIcon.snp.makeConstraints({ make in
            make.bottom.equalTo(tripNameLabel.snp.top).offset(-35.0)
            make.centerX.equalToSuperview()
        })
        
        confirmBtn.snp.makeConstraints({ make in
            make.bottom.equalToSuperview().offset(-50.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().offset(-15.0)
        })
    }
    
    private func bindViewModel(){
        confirmBtn.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.navigationVM.completeBtnAction()
            }
            .store(in: &cancellables)
        
        navigationVM.completeButtonTapped
            .sink { [weak self] in
                print("ddad")
                self?.navigationController?.popToRootViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    
    func openWithCompanionMode(){
        [backButton, horizontalStackView].forEach({ self.view.addSubview($0) })
        
        backButton.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10.0)
        })
        
        horizontalStackView.snp.makeConstraints({ make in
            make.centerX.centerY.equalToSuperview()
        })
        
        self.createTripNoticeLabel.text = "여행에 초대되었어요"
        self.confirmBtn.setTitle("같이 여행 준비 하기", for: .normal)
        self.inviteCompanionBtn.isHidden = true
        self.viewTitle.isHidden = true
        self.backButton.isHidden = false
        self.horizontalStackView.isHidden = false
    }
    
    func triggerHaptic() {
        //얇은 진동 두번
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.prepare()
        haptic.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            haptic.impactOccurred()
        }
    }
}
