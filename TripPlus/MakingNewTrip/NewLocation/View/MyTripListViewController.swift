//
//  MyTripViewController.swift
//  TripPlus
//
//  Created by 유대상 on 1/3/25.
//

import Foundation
import UIKit
import SnapKit
import Combine
import RxSwift
import RxCocoa

class MyTripViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private let disposeBag = DisposeBag()

    private lazy var myTripEmptyView: MyTripEmptyView = {
        let view = MyTripEmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
    }
    
    
    private func setViews() {
        
        self.view.addSubview(myTripEmptyView)
        
        myTripEmptyView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset((self.view.frame.height - self.view.safeAreaInsets.top - self.view.safeAreaInsets.bottom) / 3.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(95.0)
        })
        
        myTripEmptyView.makeTripBtn.isUserInteractionEnabled = true
//        myTripEmptyView.makeTripBtn.controlPublisher(for: UIControl.Event.touchUpInside)
//            .sink { [weak self] _ in
//                self?.myTripEmptyView.makeTripBtn.isHidden = true
//            }
//            .store(in: &cancellables)
        
        myTripEmptyView.makeTripBtn.rx.tap
                   .subscribe(onNext: { [weak self] in
//                       self?.myTripEmptyView.isHidden = true
//                       self?.myTripEmptyView.makeTripBtn.titleLabel?.textColor = UIColor(named: "grayA")

                       print("삑")
                   })
                   .disposed(by: disposeBag)
    }
    
}
