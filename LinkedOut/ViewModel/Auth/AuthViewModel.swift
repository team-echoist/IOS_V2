//
//  HomeViewModel.swift
//  LinkedOut
//
//  Created by 이상하 on 7/30/24.
//

import RxSwift

public class AuthViewModel: BaseViewModel, AuthViewModelType {
    
    // MARK: Repository
    fileprivate let authRepository: AuthRepositoryType
    
    // MARK: Initialize
    public init(authRepository: AuthRepositoryType) {
        self.authRepository = authRepository
    }
    
    public func getHealthcheck() -> Single<ApiWebResult> {
        let observable = self
            .authRepository
            .getHealthCheck()
            .flatMap { (response) in
                return Single.just(response)
            }
        return observable
    }
}
