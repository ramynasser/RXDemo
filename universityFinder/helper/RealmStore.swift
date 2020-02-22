//
//  RealmStore.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RealmStore {
    private let realm = try! Realm()
    private var notification: NotificationToken? = nil

    func save(repository: Repository) {
        try! self.realm.write {
            self.realm.add(repository)
        }
    }
    func update(repository: Repository, lastViewed: NSDate) {
        try! self.realm.write {
            repository.lastViewed = lastViewed
            self.realm.add(repository)
        }
    }
    func load() -> Observable<Repository> {
        return Observable<Repository>.deferred {
            return Observable.create { observer in
                let repositories = self.realm.object(ofType: Repository.self, forPrimaryKey: "lastViewed")
                self.notification = repositories!.observe { changes in
                    switch changes {
                    case .initial(let repos):
                        observer.onNext(Array(repos))
                    case .update(let repos, _, _, _):
                        observer.onNext(Array(repos))
                    case .error(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
            }
        }
    }
    
}
