//
//  LoginController.swift
//  universityFinder
//
//  Created by Ramy Nasser on 10/1/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import MBProgressHUD
class LoginController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var disposeBag = DisposeBag()
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    var viewModel: LoginViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityView)
        activityView.startAnimating()
        activityView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(loginButton)
            ConstraintMaker.top.equalTo(loginButton.snp.bottom).offset(16)
        }
        let service = GithubService(provider: GithubProvider)
        viewModel = LoginViewModel(authService: service)
        guard let vm = viewModel else {
            return
        }
        bindToRx(viewModel: vm)
        // Do any additional setup after loading the view.
    }
    

    private func bindToRx(viewModel: LoginViewModel) {
        viewModel
            .activityIndicator.asDriver()
            .debug()
            .distinctUntilChanged()
            .drive(self.activityView.rx.isAnimating)
            .disposed(by:self.disposeBag)
        
        
        viewModel
            .activityIndicator.asDriver()
            .debug()
            .distinctUntilChanged()
            .drive(onNext: { active in
                if (active){
                    MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
                } else {
                    MBProgressHUD.hide(for:((UIApplication.shared.delegate?.window)!)!, animated: true)
                }
            }).disposed(by: disposeBag)
        
        
        viewModel.loginActionResult.asObservable().subscribe {
            print($0)
        }.disposed(by:self.disposeBag)
        
        
        loginButton.rx.tap.bind(to:viewModel.loginButtonDidTap).disposed(by:self.disposeBag)

        emailTextField
        .rx
        .text
        .orEmpty
        .bind(to: viewModel.name)
        .disposed(by: disposeBag)

        passwordTextField
        .rx
        .text
        .orEmpty
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
       _  = viewModel.isValid.subscribe(onNext: { [unowned self] isValid in
            self.loginButton.backgroundColor = isValid ? UIColor.red : UIColor.lightGray
        })
        
    }

}
