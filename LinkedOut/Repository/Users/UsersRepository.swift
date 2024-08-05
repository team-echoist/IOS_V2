// 
//  UsersRepository.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import RxSwift
import Moya
import SwiftyUserDefaults

public final class UsersRepository: UsersRepositoryType {
    
    // MARK: Property
    public typealias Dependencies = HasNetworking & HasPushStore
    fileprivate let networking: LinkedOutNetworking
    fileprivate let pushStore: PushStoreType
    
    // MARK: Initialize
    public init(dependencies: Dependencies) {
        self.networking = dependencies.networking
        self.pushStore = dependencies.pushStore
        
    }
    
    public func userInfo() -> Single<ApiResult<UserInfoData>> {
        let observable = self
            .networking
            .request(.getUserInfo)
            .map(ApiResult<UserInfoData>.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }
}
