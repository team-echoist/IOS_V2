// 
//  UsersViewModelType.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import RxSwift

public protocol UsersViewModelType {
    
    func getUserInfo() -> Single<ApiResult<UserInfoData>>
}
