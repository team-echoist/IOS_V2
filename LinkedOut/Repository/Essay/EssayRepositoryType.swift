// 
//  EssayRepositoryType.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift

public enum EssayType: String {
    case recommend = "recommend"
    case privateType = "private"
    case publish = "publish"
}

public protocol EssayRepositoryType {
    
    func getEssays() -> Single<ApiResult<EssayArray>>
    
    func postEssays()
    
    func getEssayDetail(essayId: Int, essayType: EssayType) -> Single<ApiResult<EssayDetailResponse>>
    
    func getEssayRecommend(limit: Int?) -> Single<ApiResult<EssayNonePagingArray>>
    
    func getEssaysFollowings(page: Int?, limit: Int?) -> Single<ApiResult<EssayNonePagingArray>>
    
    func getEssaysSentence(type: String, limit: Int?) -> Single<ApiResult<EssaySentenceArray>>
    
    func getEssaysRecent(page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>>
    
    func getEssaysSearch(keyword: String, page: Int?, limit: Int?) -> Single<ApiResult<EssayArray>>

}
