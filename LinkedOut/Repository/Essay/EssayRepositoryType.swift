// 
//  EssayRepositoryType.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift

public protocol EssayRepositoryType {
    func getEssays() -> Single<ApiResult<EssayArray>>
    func postEssays()
}
