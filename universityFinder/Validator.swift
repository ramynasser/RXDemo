////
////  Validator.swift
////  universityFinder
////
////  Created by Ramy Nasser on 9/30/19.
////  Copyright © 2019 Ramy Nasser. All rights reserved.
////
//
//import Foundation
//import RxCocoa
//import RxSwift
//class Validator {
//    
//    let disposeBag = DisposeBag()
//    private static var validatorsDictionary = [UITextField: Validator]()
//    private weak var textField: UITextField?
//    private var errorMessage: String = ""
//    public var isValid = BehaviorSubject<Bool>(value: false)
//    var observables = [Observable<Bool>]()
//
//    
//    private var internalIsValid: Bool {
//        willSet {
//            self.isValid.onNext(newValue)
//        }
//    }
//
//    private init(textField: UITextField) {
//        self.textField = textField
//        internalIsValid = true
//    }
//    
//    deinit {
//        if let textField = self.textField {
//            Validator.validatorsDictionary[textField] = nil
//        }
//    }
//    
//    public class func getInstance(textField: UITextField) -> Validator {
//        if let validator = Validator.validatorsDictionary[textField] {
//            return validator
//        } else {
//            let validator = Validator(textField: textField)
//            Validator.validatorsDictionary[textField] = validator
//            return validator
//        }
//    }
//
//    func build(_ rules: TextFieldValidationRule...) -> Validator {
//        if rules.contains(Validator.Rule.email) {
//            observables.append(self.email())
//        }
//
//        return self
//    }
//
//  
//}
//enum TextFieldValidationRule {
//
//    case notEmpty(textField:UITextField?)
//    case email
//    case number
//    
//    func validation()  {
//        switch self {
//        case .notEmpty:
//            notEmptyAction(textField: textField)
//        default:
//            break
//        }
//    }
//    
//    private func notEmptyAction(textField:UITextField?) -> Observable<Bool> {
//        let variable = BehaviorRelay<Bool>(value: false)
//        
//        textField?.rx.controlEvent([.editingChanged])
//            .asDriver()
//            .drive(onNext: {
//                var placeholder = ""
//                if let p = textField?.placeholder {
//                    placeholder = p
//                }
//                if (textField?.text?.isEmpty)! {
//                    variable.accept(false)
//                } else {
//                    variable.accept(true)
//                }
//            })
//            .disposed(by: DisposeBag())
//        
//        return variable.asObservable()
//    }
//    
//}
//extension UITextField {
//    var validator: Validator {
//        return Validator.getInstance(textField: self)
//    }
//}
//
////self.viewModel.isValid(observables: self.usernameField.validator.isValid,
////                       self.passwordField.validator.isValid
////    )
////    .subscribe(onNext: { (boolValue) in
////        UiHelpers.setEnabled(button: self.loginButton, isEnabled: boolValue)
////    })
////    .disposed(by: self.disposeBag)
//class TextFieldHelper {
//    static func isValid(observables: Observable<Bool>...) -> Observable<Bool> {
//        let distinctObservables = observables.map {
//            $0.distinctUntilChanged()
//        }
//        
//        let observable = Observable.combineLatest(distinctObservables) { values -> Bool in
//            var result = false
//            values.forEach({ (value) in
//                result = result && value
//            })
//            return result
//        }
//        return observable
//    }
//    
//}
