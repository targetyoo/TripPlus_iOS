//
//  LoginViewModel.swift
//  TripPlus
//
//  Created by 유대상 on 8/25/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum LoginError: Error {
    case badRequest
    case serverError
}

final class LoginViewModel {
    let emailRelay = BehaviorRelay<String>(value: "")
    let passwordRelay = BehaviorRelay<String>(value: "")
    
    var isLoginSucceed = PublishSubject<LoginResponse>()
    
    var isValid: Observable<Bool> {
        return Observable
            .combineLatest(emailRelay, passwordRelay)
            .map { email, password in
                print("Email : \(email), Password : \(password)")
                return !email.isEmpty && email.contains("@") && email.contains(".") && password.count > 0 && !password.isEmpty
            }
    }
    
    struct Input {
            let emailText: ControlProperty<String?>
            let passwordText: ControlProperty<String?>
            let loginTap: ControlEvent<Void>
    }
    
    struct Output {
            // relay 초기값 .. ?
            let emailRelay: BehaviorRelay<String>
            let passwordRelay: BehaviorRelay<String>
            
            // 텍스트필드 입력값
            let emailText: ControlProperty<String>
            let passwordText: ControlProperty<String>
            
            // 버튼 탭
            let loginTap: ControlEvent<Void>
            
            // 로그인 성공 유무 > Output으로 해야 하는가?
            let isLoginSucceed: PublishSubject<LoginResponse>
            
            // 유효성 판단
            let isValid: Driver<Bool>
    }
    
    
    func transform(from input: Input) -> Output {
            let emailText = input.emailText.orEmpty
            let passwordText = input.passwordText.orEmpty
            
            let isValid = isValid.asDriver(onErrorJustReturn: false)
            
            return Output(emailRelay: emailRelay,
                          passwordRelay: passwordRelay,
                          emailText: emailText,
                          passwordText: passwordText,
                          loginTap: input.loginTap,
                          isLoginSucceed: isLoginSucceed,
                          isValid: isValid)
    }
    
    
    func requestLogin(_ loginRequest: LoginRequest) {
        let url = "https://jsonplaceholder.typicode.com/todos/1/users"
        let headers : HTTPHeaders = ["Content-Type" : "application/json"]
//        let params: Parameters = ["email": loginRequest.email, "password" : loginRequest.password]
        
        let request = AF.request(url,
                                 method: .post,
//                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        request.response(completionHandler: { [weak self] response in
            switch response.result {
            case .success(let value):
                guard let statusCode = response.response?.statusCode else { return }
                
                if statusCode == 201 {
                    let ii = LoginResponse(name: "Suc")
                    self?.isLoginSucceed.onNext(ii)
                } else if statusCode == 400 {
                    self?.isLoginSucceed.onError(LoginError.badRequest)
                } else if statusCode  == 500 {
                    self?.isLoginSucceed.onError(LoginError.serverError)
                }
                
            case .failure(let error):
                self?.isLoginSucceed.onError(LoginError.badRequest)
                print(error)
            }
        })
            
//        request.responseDecodable(of: LoginResponse.self) { [weak self] response in
//            guard let self = self else { return }
//            
//            switch response.result {
//            case .success(let value):
//                
//                guard let statusCode = response.response?.statusCode else { return }
//                
//                if statusCode == 200 {
//                    self.isLoginSucceed.onNext(value)
//                } else if statusCode == 400 {
//                    self.isLoginSucceed.onError(LoginError.badRequest)
//                } else if statusCode  == 500 {
//                    self.isLoginSucceed.onError(LoginError.serverError)
//                }
//                
//            case .failure(let error):
//                self.isLoginSucceed.onError(LoginError.badRequest)
//                print(error)
//            }
//        }
    }
}
