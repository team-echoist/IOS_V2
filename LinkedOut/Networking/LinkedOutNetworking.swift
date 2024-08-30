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
    case postEssays(essayCreateData: EssayCreateData)
    case getEssayDetail(essayId: Int, type: EssayType)
    case getEssaysRecommend(limit: Int = 20)
    case getEssaysFollowings(page: Int = 1, limit: Int = 20)
    case getEssaysSentence(type: String = "first", limit: Int = 20)
    case getEssaysRecent(page: Int = 1, limit: Int = 20)
    case getEssaysSearch(keyword: String, page: Int = 1, limit: Int = 20)
}

// MARK: Route

enum ApiRoute: String {
    // auth
    case authHealthCheck = "auth/health-check"
    
    // user
    case userInfo = "users/info"
    
    // essay
    case essays = "essays" // 에세이 조회
    case essaysRecommend = "essays/recommend" // 랜덤 추천 에세이 리스트 조회
    case essaysFollowings = "essays/followings" // 팔로우 중인 유저들의 최신 에세이 리스트
    case essaysSentence = "essays/sentence" // 한 문장 에세이 조회
    case essaysRecent = "essays/recent" // 최근 조회한 에세이 목록
    case essaysSearch = "essays/search" // 에세이 검색
}

// MARK: Param

public enum ApiParam: String {
    case page = "page" // (number, optional): 조회할 페이지를 지정합니다. 기본값은 1입니다.
    case limit = "limit" // (number, optional): 조회할 에세이 수를 지정합니다. 기본값은 10입니다.
    case published = "published" // 발행 여부 (true 또는 false)
    case storyId = "storyId" // 특정 스토리에 속한 에세이만 조회
    case keyword = "keyword" // 검색할 키워드
    case type = "type"
    case pageType = "pageType"
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
        // Essasy
        case .getEssays:
            return .get(ApiRoute.essays.rawValue)
        case .postEssays:
            return .post(ApiRoute.essays.rawValue)
        case .getEssayDetail(let essayId, _):
            let url = "\(ApiRoute.essays.rawValue)/\(essayId)"
            return .get(url)
        case .getEssaysRecommend:
            return .get(ApiRoute.essaysRecommend.rawValue)
        case .getEssaysFollowings:
            return .get(ApiRoute.essaysFollowings.rawValue)
        case .getEssaysSentence:
            return .get(ApiRoute.essaysSentence.rawValue)
        case .getEssaysRecent:
            return .get(ApiRoute.essaysRecent.rawValue)
        case .getEssaysSearch:
            return .get(ApiRoute.essaysSearch.rawValue)
        }
    }
    
    public var parameters: MoyaSugar.Parameters? {
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
        case .postEssays(let data):
            let dic: [String: Any] = [
                ApiParam.title.rawValue: data.title,
                ApiParam.content.rawValue: data.content,
                ApiParam.status.rawValue: data.status,
                ApiParam.linkedOutGauge.rawValue: data.linkedOutGauge,
                ApiParam.latitude.rawValue: data.latitude,
                ApiParam.longitude.rawValue: data.longitude,
                ApiParam.location.rawValue: data.location,
                ApiParam.tags.rawValue: data.tags,
            ]
            return ApiParam.makeParam(from: dic, method: .post)
        case .getEssayDetail(_, let essayType):
            let dic: [String: Any] = [
                ApiParam.pageType.rawValue: essayType.rawValue
            ]
            
            return ApiParam.makeParam(from: dic, method: .get)
        case .getEssaysRecommend(let limit):
            let dic: [String: Any] = [
                ApiParam.limit.rawValue: limit
            ]
            return ApiParam.makeParam(from: dic, method: .get)
        case .getEssaysFollowings(let page, let limit):
            let dic: [String: Any] = [
                ApiParam.page.rawValue: page,
                ApiParam.limit.rawValue: limit
            ]
            return ApiParam.makeParam(from: dic, method: .get)
        case .getEssaysSentence(let type, let limit):
            let dic: [String: Any] = [
                ApiParam.type.rawValue: type,
                ApiParam.limit.rawValue: limit
            ]
            return ApiParam.makeParam(from: dic, method: .get)
        case .getEssaysRecent(let page, let limit):
            let dic: [String: Any] = [
                ApiParam.page.rawValue: page,
                ApiParam.limit.rawValue: limit
            ]
            return ApiParam.makeParam(from: dic, method: .get)
        case .getEssaysSearch(let keyword, let page, let limit):
            let dic: [String: Any] = [
                ApiParam.keyword.rawValue: keyword,
                ApiParam.page.rawValue: page,
                ApiParam.limit.rawValue: limit
            ]
            return ApiParam.makeParam(from: dic, method: .get)
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
                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTc5LCJpYXQiOjE3MjM1MjU2NDIsImV4cCI6MTcyNjExNzY0Mn0.c8LZT0FeDT-7DYYxDgjYSoq72f0Gb57ibsBvdr7QV6g"
                // PreferenceDataManager.getAccessToken() as! String,
        ]
    }
}

