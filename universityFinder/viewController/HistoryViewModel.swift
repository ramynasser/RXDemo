//
//  HistoryViewModel.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxSwift
class HistoryViewModel {
    
    // Output
    var history: Observable<[HistoryCellViewModel]>?
    let loginButtonDidTap = PublishSubject<Void>()

    private let store: RealmStore
    private let disposeBag: DisposeBag

    init(store: RealmStore) {
        self.store = store
        self.disposeBag = DisposeBag()
        
        history = self.store
            .load()
            .flatMap { repositories -> Observable<[HistoryCellViewModel]> in
                return Observable
                    .from(repositories)
                    .map { repo in
                        return HistoryCellViewModel(repository: repo)
                    }
                    .toArray()
        }
    }
}
