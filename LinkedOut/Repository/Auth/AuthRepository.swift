//
//  AuthRepository.swift
//  LinkedOut
//
//  Created by 이상하 on 7/30/24.
//

import RxSwift
import Moya
import SwiftyUserDefaults

public final class AuthRepository: AuthRepositoryType {

    // MARK: Property
    public typealias Dependencies = HasNetworking & HasPushStore
    fileprivate let networking: LinkedOutNetworking
    fileprivate let pushStore: PushStoreType
    
    // MARK: Initialize
    public init(dependencies: Dependencies) {
        self.networking = dependencies.networking
        self.pushStore = dependencies.pushStore
    }
    
    
    public func getHealthCheck() -> Single<ApiWebResult> {
        let observable = self
            .networking
            .request(.authHealthCheck)
            .map(ApiWebResult.self)
            .flatMap { (response) in
                return Single.just(response)
            }
            .debug()
        
        return observable
    }   
}
