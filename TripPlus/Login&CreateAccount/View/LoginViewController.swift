//
//  LoginViewController.swift
//  TripPlus
//
//  Created by 유대상 on 8/25/24.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

protocol BaseViewControllerAttribute {
    func configureHierarchy()
    func setAttribute()
    func bind()
}


final class LoginViewController: UIViewController{
    // MARK: - UI Property
//    private var idTextField = UITextField().then {
//        $0.borderStyle = .roundedRect
//    }
//    
    
    private var idTextField: UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "id PlaceHolder"
        return txtField
    }()
    
    private var passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "password PlaceHolder"
        return txtField
    }()
    
    private var loginButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemPink
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    
    // MARK: - Property
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        setAttribute()
        bind()
    }
}


extension LoginViewController: BaseViewControllerAttribute {
    func configureHierarchy() {
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        idTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(50)
        }
        
        
        //placeHolder 설정
//        viewModel.emailRelay
//            .bind(to: idTextField.rx.text)
//            .disposed(by: disposeBag)
//        
//        viewModel.passwordRelay
//            .bind(to: passwordTextField.rx.text)
//            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .withUnretained(self)
    }
    
    
    /*
     MVVM에서의 ViewController의 역할
     1. 각 텍스트 필드에서 값을 받아서 뷰모델로 전달.
     2. 뷰모델에서 유효성 검사 후, 값에 따라서 UI를 업데이트 (로그인 버튼이 활성화 등)
     3. 로그인 버튼을 누를 시, 뷰모델에서 처리 (View Model에서는 APIManager를 통해 통신)
     4. 서버 통신 이후 값에 따라서 알림창을 띄워주면 된다.(= 로그인 버튼을 눌렀을 때, 서버 통신을 하고, 이의 결과에 따라서 다른 알림창을 띄워주면 된다.)
     
     입력 이벤트가 발생했을 때 :
     viewModel.emailRelay
         .bind(to: emailTextField.rx.text)
         .disposed(by: disposeBag)
     viewModel.passwordRelay
         .bind(to: passwordTextField.rx.text)
         .disposed(by: disposeBag)
     */
    
    
    func setAttribute() {
        view.backgroundColor = .white
    }
    
    func bind() {
        let input = LoginViewModel.Input(emailText: idTextField.rx.text,
                                               passwordText: passwordTextField.rx.text,
                                               loginTap: loginButton.rx.tap)
              
              let output = viewModel.transform(from: input)
              
      //        viewModel.emailRelay
              output.emailRelay
                  .bind(to: idTextField.rx.text)
                  .disposed(by: disposeBag)
              
      //        viewModel.passwordRelay
              output.passwordRelay
                  .bind(to: passwordTextField.rx.text)
                  .disposed(by: disposeBag)
              
              output.emailText
                  .bind(to: viewModel.emailRelay)
                  .disposed(by: disposeBag)
              
              output.passwordText
                  .bind(to: viewModel.passwordRelay)
                  .disposed(by: disposeBag)
              
              output.isValid
                  .drive(loginButton.rx.isEnabled)
                  .disposed(by: disposeBag)
              
              output.isValid
                  .map { $0 == true ? UIColor.systemPink : UIColor.systemGray4 }
                  .drive(loginButton.rx.backgroundColor)
                  .disposed(by: disposeBag)
              
              output.loginTap
                  .withUnretained(self)
                  .bind { vc, _ in
                      let request = LoginRequest(email: vc.viewModel.emailRelay.value, password: vc.viewModel.passwordRelay.value)
                      vc.viewModel.requestLogin(request)
                  }
                  .disposed(by: disposeBag)
              
              output.isLoginSucceed
                  .withUnretained(self)
                  .subscribe { vc, response in
                      vc.presentAlert("로그인 성공", "\(response.name)님 환영합니다.")
                  } onError: { [weak self] error in
                      guard let self = self else { return }
                      self.presentAlert("로그인 실패", "\(error)")
                  } onCompleted: {
                      print("완료")
                  } onDisposed: {
                      print("버려")
                  }
                  .disposed(by: disposeBag)
    }
    
    private func presentAlert(_ title: String, _ message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
}
