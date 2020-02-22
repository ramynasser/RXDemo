//
//  GithubService.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

enum AutenticationError: Error {
    case server
    case badReponse(String)
    case badCredentials
}

enum AutenticationStatus {
    case none
    case error(AutenticationError)
    case success(String)
}

protocol ServiceType {
    var provider: MoyaProvider<GitHub> { get }
    func downloadImage(from url: URL?)   -> Observable<UIImage?>
    func searchRepository(name: String) -> Observable<[Repository]>
    func login(username:String, password:String) ->Observable<AutenticationStatus>
}
class GithubService: ServiceType {
    var provider: MoyaProvider<GitHub>
    
    init(provider: MoyaProvider<GitHub>) {
        self.provider = provider
    }
    
    func downloadImage(from url: URL?) -> Observable<UIImage?> {
        guard let url = url else {
            return Observable.just(nil)
        }
        let request = URLRequest(url: url)
        return URLSession.shared
        .rx
        .data(request: request)
        .map { datat in
            return UIImage(data: datat)
        }.startWith(UIImage())
        .observeOn(MainScheduler.asyncInstance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .share(replay: 1)

    }
    
   
    func searchRepository(name: String) -> Observable<[Repository]> {
        if name.isEmpty {
            return Observable.just([])
        }
        return provider
        .rx
        .request(.search(query: name))
        .asObservable()
        .retry(3)
        .observeOn(MainScheduler.instance)
        .mapJSON()
        .map{JSON($0)}
        .map{ json in
            json["items"].arrayValue.map {
                Repository.fromJSON($0)
            }
        }


    }
    func login(username: String, password: String)->Observable<AutenticationStatus> {
        return Observable<AutenticationStatus>.create{
            observer in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(2)){
                if username == "root" && password == "123456" {
                    observer.onNext(.success(username))
                    observer.onCompleted()
                } else {
                    observer.onNext(.error(.badReponse("用户名或密码错误")))
                    observer.onCompleted()
                }
            }
            return Disposables.create();
        }
    }
    
   
}
