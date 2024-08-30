// 
//  EssayViewModel.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift

public class EssayViewModel: BaseViewModel, EssayViewModelType {
    
    /// Repository
    fileprivate let essayRepository: EssayRepositoryType

    // MARK: Initialize
    public init(essayRepository: EssayRepositoryType) {
        self.essayRepository = essayRepository
    }
    
    public func getEssays() -> Single<ApiResult<EssayArray>> {
        let observable = self
            .essayRepository
            .getEssays()
            .flatMap { (response) in
                return Single.just(response)
            }
        return observable
    }
    
    public func postEssays(essayCraeteData: EssayCreateData) -> Single<ApiWebResult> {
        let observable = self
            .essayRepository
            .postEssays(essayCraeteData: essayCraeteData )
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
    public func getEssayDetail(essayId: Int, type: EssayType) -> Single<ApiResult<EssayDetailResponse>> {
        let observable = self
            .essayRepository
            .getEssayDetail(essayId: essayId, essayType: type)
            .flatMap { (response) in
                return Single.just(response)
            }
        return observable
    }
    
    public func getEssayRecommend(limit: Int?) -> Single<ApiResult<EssayNonePagingArray>> {
        let observable = self
            .essayRepository
            .getEssayRecommend(limit: limit)
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
    public func getEssaysFollowings(page: Int?, limit: Int?) -> Single<ApiResult<EssayNonePagingArray>> {
        let observable = self
            .essayRepository
            .getEssaysFollowings(page: page, limit: limit)
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
    public func getEssaysSentence(type: String, limit: Int?) -> Single<ApiResult<EssaySentenceArray>> {
        let observable = self
            .essayRepository
            .getEssaysSentence(type: type, limit: limit)
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
    public func getEssaysRecent(page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>> {
        let observable = self
            .essayRepository
            .getEssays()
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
    public func getEssaysSearch(keyword: String, page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>> {
        let observable = self
            .essayRepository
            .getEssaysSearch(keyword: keyword, page: page, limit: limit)
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
}
