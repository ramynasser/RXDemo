//
//  RepositoryCell.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import UIKit
import RxSwift
class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var organization: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!
    
    static let cellIdentifier = "RepositoryCell"
    private var disposeBag = DisposeBag()

    
    func configureCell(viewModel: RepositoryCellViewModel) {
       
        viewModel.repositoryName
        .asObservable()
        .bind(to: name.rx.text)
        .disposed(by: disposeBag)
        
        viewModel.repositoryOrganization
            .asObservable()
            .bind(to: self.organization.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.repositoryStars
            .asObservable()
            .bind(to: self.stars.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.repositoryForks
            .asObservable()
            .bind(to: self.forks.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.repositoryImage
            .asObservable()
            .bind(to: self.avatar.rx.image)
            .disposed(by: disposeBag)

        
    }
}
