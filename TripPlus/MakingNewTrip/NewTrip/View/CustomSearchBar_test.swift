//
//  CustomSearchBar.swift
//  TripPlus
//
//  Created by 유대상 on 9/22/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomSearchBar : UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    //검색 버튼 탭 이벤트
    //PublishRelay = Error를 받지 않음
    let searchButtonTabbed = PublishRelay<Void>()
    
    //외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        //searchbar - searchBtn Tabbed, button tabbed
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTabbed)
            .disposed(by: disposeBag)
        
        searchButtonTabbed
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        //다 검색 후에 버튼을 눌러야 입력되도록 설정(추후 수정 필요)
        self.shouldLoadResult = searchButtonTabbed
            .withLatestFrom(self.rx.text){ $1 ?? "" }
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
    }
    
    private func attribute(){
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    private func layout(){
        addSubview(searchButton)
        
        searchTextField.leftView = nil //기본 돋보기 모양 제거
        searchButton.tintColor = .grayB
        
        searchTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12.0)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(searchTextField.snp.trailing).inset(12.0)
            $0.centerY.equalToSuperview()
        }
    }
}

extension Reactive where Base: CustomSearchBar {
    var endEditing: Binder<Void>{
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
