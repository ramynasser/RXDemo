//
//  SearchViewModel.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import Foundation
import RxSwift
import RxCocoa
import RxSwiftUtilities

class SearchViewModel {
    // Input
    var searchQuery   = Variable("")
    var selectedIndex = PublishSubject<IndexPath>()
    // Output
    var repositories: Observable<[RepositoryCellViewModel]>
    var showLoading: Observable<Bool>
    var selectedRepo: Observable<DetailViewModel>
    
    private let service: ServiceType
    private let disposeBag = DisposeBag()
    private var repos:Variable<[Repository]>


 
    init(service: ServiceType) {
        self.service = service


        let showLoadingSubject = Variable(false)
        let repos = Variable<[Repository]>([])
        self.repos = repos

        self.showLoading = showLoadingSubject.asObservable().distinctUntilChanged()

         let noRepoData:Observable<[RepositoryCellViewModel]> = searchQuery
            .asObservable()
            .filter{$0.isEmpty}
            .flatMap{ _ in
                Observable.just([])
             }

        let repoData:Observable<[RepositoryCellViewModel]> = searchQuery
        .asObservable()
            .filter{!$0.isEmpty}
            .distinctUntilChanged()
            .do(onNext: { _ in
              showLoadingSubject.value = true
            })
            .flatMapLatest{ query -> Observable<[Repository]> in
               return service.searchRepository(name: query)
            }.do(onNext: { repositories in
                repos.value = repositories
            showLoadingSubject.value = false
            })
            .flatMapLatest { repositories -> Observable<[RepositoryCellViewModel]> in
                return Observable
                       .from(repositories)
                    .map{return RepositoryCellViewModel(repository: $0, service: service)}
                .toArray()

        }

        self.repositories = Observable.of(noRepoData, repoData).merge()

        selectedRepo = self.selectedIndex
            .asObservable()
            .map{indexPath in
                let repo = repos.value[indexPath.row]
                let store = RealmStore()
                return DetailViewModel(service: service, store: store, repository: repo)
        }.share(replay: 1)


    }
}
