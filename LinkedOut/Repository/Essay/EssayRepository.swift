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
    
    
    // MARK: Property
    public typealias Dependencies = HasNetworking & HasPushStore
    fileprivate let networking: LinkedOutNetworking
    fileprivate let pushStore: PushStoreType
    
    // MARK: Initialize
    public init(dependencies: Dependencies) {
        self.networking = dependencies.networking
        self.pushStore = dependencies.pushStore
    }
}
