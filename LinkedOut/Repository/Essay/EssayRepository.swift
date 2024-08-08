// 
//  EssayRepository.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift
import Moya
import SwiftyUserDefaults

public final class EssayRepository: EssayRepositoryType {
    
    // MARK: Property
    public typealias Dependencies = HasNetworking & HasPushStore
    fileprivate let networking: LinkedOutNetworking
    fileprivate let pushStore: PushStoreType
    
    // MARK: Initialize
    public init(dependencies: Dependencies) {
        self.networking = dependencies.networking
        self.pushStore = dependencies.pushStore
    }
    
    let defaultPage = 1
    let defaultLimit = 20
    let defaultType = "first"
    
    public func getEssays() -> Single<ApiResult<EssayArray>> {
        let observable = self
            .networking
            .request(.getEssays)
            .map(ApiResult<EssayArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
    
    public func postEssays() {
        
    }
    
    public func getEssayRecommend(limit: Int?) -> Single<ApiResult<EssayNonePagingArray>> {
        let observable = self
            .networking
            .request(.getEssaysRecommend(limit: limit ?? self.defaultLimit))
            .map(ApiResult<EssayNonePagingArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
    
    public func getEssaysFollowings(page: Int?, limit: Int?) -> Single<ApiResult<EssayNonePagingArray>> {
        let observable = self
            .networking
            .request(.getEssaysFollowings(page: page ?? self.defaultPage, limit: limit ?? self.defaultLimit))
            .map(ApiResult<EssayNonePagingArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
    
    public func getEssaysSentence(type: String, limit: Int?) -> Single<ApiResult<EssaySentenceArray>> {
        let observable = self
            .networking
            .request(.getEssaysSentence(type: type, limit: limit ?? self.defaultLimit))
            .map(ApiResult<EssaySentenceArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
    
    public func getEssaysRecent(page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>> {
        let observable = self
            .networking
            .request(.getEssaysRecent(page: page ?? self.defaultPage, limit: limit ?? self.defaultLimit))
            .map(ApiResult<EssayArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
    
    public func getEssaysSearch(keyword: String, page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>> {
        let observable = self
            .networking
            .request(.getEssaysSearch(keyword: keyword, page: page ?? self.defaultPage, limit: limit ?? self.defaultLimit))
            .map(ApiResult<EssayArray>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
}
