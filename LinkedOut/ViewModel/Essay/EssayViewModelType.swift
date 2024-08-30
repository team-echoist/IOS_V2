// 
//  EssayViewModelType.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift

public protocol EssayViewModelType {
    
    func getEssays() -> Single<ApiResult<EssayArray>>
    func postEssays(essayCraeteData: EssayCreateData) -> Single<ApiWebResult>
    func getEssayDetail(essayId: Int, type: EssayType) -> Single<ApiResult<EssayDetailResponse>>
    func getEssayRecommend(limit: Int?) -> Single<ApiResult<EssayNonePagingArray>>
    func getEssaysFollowings(page: Int?, limit: Int?) -> Single<ApiResult<EssayNonePagingArray>>
    func getEssaysSentence(type: String, limit: Int?) -> Single<ApiResult<EssaySentenceArray>>
    func getEssaysRecent(page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>>    
    func getEssaysSearch(keyword: String, page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>>
}
