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
    // auth
    case authHealthCheck
    // user
    case getUserInfo
    // essay
    case getEssays
    case postEssays
}

// MARK: Route

enum ApiRoute: String {
    // auth
    case authHealthCheck = "auth/health-check"
    
    // user
    case userInfo = "users/info"
    
    // essay
    case essays = "essays"
}

// MARK: Param

public enum ApiParam: String {
    case page = "page" // (number, optional): 조회할 페이지를 지정합니다. 기본값은 1입니다.
    case limit = "limit" // (number, optional): 조회할 에세이 수를 지정합니다. 기본값은 10입니다.
    case published = "published" // 발행 여부 (true 또는 false)
    case storyId = "storyId" // 특정 스토리에 속한 에세이만 조회
    case title = "title"
    case content = "content"
    case linkedOutGauge = "linkedOutGauge"
    case thumbnail = "thumbnail"
    case status = "status"
    case latitude = "latitude"
    case longitude = "longitude"
    case location = "location"
    case tags = "tags"

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
            case .getUserInfo:
                return .get(ApiRoute.userInfo.rawValue)
            case .getEssays:
                return .get(ApiRoute.essays.rawValue)
            case .postEssays:
                return .post(ApiRoute.essays.rawValue)
        }
    }
    
    public var parameters: MoyaSugar.Parameters? {
        return ApiParam.makeParam(from: [:], method: .get)
        switch self {
            // auth
            case .authHealthCheck:
                return ApiParam.makeParam(from: [:], method: .get)
            // user
            case .getUserInfo:
                return ApiParam.makeParam(from: [:], method: .get)
            // essay
            case .getEssays:
                let dic: [String: Any] = [:]
                return ApiParam.makeParam(from: dic, method: .get)
            case .postEssays:
                let dic: [String: Any] = [:]
                return ApiParam.makeParam(from: dic, method: .post)
            
            }
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
                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJ1c2VyMUBsaW5rZWRvdXRhcHAuY29tIiwiaWF0IjoxNzIxODkxMjI3LCJleHAiOjE3MjQ0ODMyMjd9.PBitovPYX20aqQs0poi--hEf3urJ__cPL_XAnNDLE-I"
                // PreferenceDataManager.getAccessToken() as! String,
        ]
    }
}

