//
//  LoginViewModel.swift
//  universityFinder
//
//  Created by Ramy Nasser on 10/1/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

protocol LoginViewModelType {
    // 2-Way Binding
    var name: Variable<String> { get }
    var password: Variable<String> { get }
    //input
    var loginButtonDidTap:PublishSubject<Void>{ get }
    // Output
    var loginActionResult: Driver<AutenticationStatus> { get }
    var activityIndicator: ActivityIndicator { get }
}

class LoginViewModel:LoginViewModelType {
        //input
    var name = Variable<String>("")
    var password =  Variable<String>("")

    
    var isValid: Observable<Bool>{
        return Observable.combineLatest(name.asObservable(),password.asObservable()){ email,password in
            email.count >= 3 && password.count >= 3
        }
    }
        //btn click
        let loginButtonDidTap = PublishSubject<Void>()
        // Output
        var loginActionResult:Driver<AutenticationStatus>
        var activityIndicator:ActivityIndicator = ActivityIndicator()
    
    private let disposeBag = DisposeBag()

        
    init(authService:ServiceType) {
        let ac = ActivityIndicator()
        activityIndicator = ac
        
            let usernameAndPassword = Observable.combineLatest(name.asObservable(), password.asObservable()) {
                ($0, $1)
            }
          
            loginActionResult = loginButtonDidTap.asObservable()
                .withLatestFrom(usernameAndPassword)
                .flatMapLatest {  (username, password) in
                    return  authService.login(username: username, password: password).trackActivity(ac)
                }.asDriver(onErrorJustReturn:.error(.server))

        
        }
    
    }

