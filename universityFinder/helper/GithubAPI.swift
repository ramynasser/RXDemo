//
//  GithubAPI.swift
//  universityFinder
//
//  Created by Ramy Nasser on 9/30/19.
//  Copyright © 2019 Ramy Nasser. All rights reserved.
//

import Foundation
import Moya

let GithubProvider = MoyaProvider<GitHub>()

public enum GitHub {
    case search(query: String)
}
extension GitHub: TargetType {
    public var headers: [String : String]? {
        return ["Content-Type": "Application/json"]
    }
    
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .search(_):
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        switch self {
        case .search :
            return GithubStubResponse.fakeData()
        }
    }
    
    public var task: Task {
        switch self {
        case .search(let query):
            
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.default)
            
        }
    }
    
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
