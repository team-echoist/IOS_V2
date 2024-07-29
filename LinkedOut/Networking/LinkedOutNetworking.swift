//
//  LinkedOutNetworking.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Moya
import MoyaSugar
import Foundation
import Alamofire
import SwiftyUserDefaults

enum EnvironmentAPI {
    case staging
    case production
    case tests
}

// MARK: Target

public enum LinkedOutAPI {
    case authHealthCheck
}

// MARK: Route

enum ApiRoute: String {
    case myAlarm = "user/myAlarm"
    case feedByStoreSeq = "feed/storeSeq"
    case searchRank = "search/rank"
    case searchUnified = "search/unified"
    case searchLocationFeed = "search/location/feed"
    case saveFeed = "save/feed"
    case authHealthCheck = "auth/health-check"
}

// MARK: Param

public enum ApiParam: String {
    case pageNum = "pageNum"
    case pageSize = "pageSize"
    case storeSeq = "storeSeq"
    case feedSeq = "feedSeq"
    case reqDate = "reqDate"
    case searchKeyword = "keyword"
    case locationKeywordSeq = "locationKeywordSeq"
    case saved = "saved"
    
    static func makeParam(from dic: [String: Any?], method: HTTPMethod) -> MoyaSugar.Parameters? {
        let params = MoyaSugar.Parameters(
            encoding: (method == .post) ? JSONEncoding.default : URLEncoding.queryString,
            values: dic
        )
        return params
    }
}

extension LinkedOutAPI: SugarTargetType {
    
    public var route: MoyaSugar.Route {
        switch self {
            case .authHealthCheck:
                return .get(ApiRoute.authHealthCheck.rawValue)
        }
    }
    
    public var parameters: MoyaSugar.Parameters? {
        return ApiParam.makeParam(from: [:], method: .get)
//        switch self {
//            case .myAlarm(let pageNum, let pageSize):
//                let dic = [
//                    FoodinkoParam.pageNum.rawValue : pageNum,
//                    FoodinkoParam.pageSize.rawValue : pageSize
//                ]
//                return FoodinkoParam.makeParam(from: dic, method: .post)
//                
//            case .feedByStoreSeq(let storeSeq):
//                let dic = [
//                    FoodinkoParam.storeSeq.rawValue : storeSeq
//                ]
//                return FoodinkoParam.makeParam(from: dic, method: .post)
//            
//            case .searchRank(let reqDate):
//                let dic = [
//                    FoodinkoParam.reqDate.rawValue : reqDate
//                ]
//                return FoodinkoParam.makeParam(from: dic, method: .get)
//            
//            case .searchUnified(let reqDate):
//                let dic = [
//                    FoodinkoParam.searchKeyword.rawValue : reqDate
//                ]
//                return FoodinkoParam.makeParam(from: dic, method: .get)
//            
//            case .searchLocationFeed(let locationKeywordSeq):
//                let dic = [
//                    FoodinkoParam.locationKeywordSeq.rawValue : locationKeywordSeq
//                ]
//                
//                return FoodinkoParam.makeParam(from: dic, method: .post)
//            
//            case .saveFeed(let feedSeq, let saved):
//                let dic = [
//                    FoodinkoParam.feedSeq.rawValue : feedSeq,
//                    FoodinkoParam.saved.rawValue : saved
//                ] as [String : Any]
//                return FoodinkoParam.makeParam(from: dic, method: .post)
//        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: Environment.rootURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    public var headers: [String : String]? {
        // TODO: go
        let locale: String = "ko"
        return ["Content-type": "application/json",
                "locale": locale,
//                "X-AUTH-TOKEN" : PreferenceDataManager.getAccessToken() as! String,                
        ]
    }
}

