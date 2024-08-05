// 
//  UsersViewModel.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import RxSwift

public class UsersViewModel: BaseViewModel, UsersViewModelType {
            
    /// Repository
    fileprivate let userRepository: UsersRepositoryType

    // MARK: Initialize
    public init(userRepository: UsersRepositoryType) {
        self.userRepository = userRepository
    }
    
    public func getUserInfo() -> Single<ApiResult<UserInfoData>> {
        let observable = self
            .userRepository
            .userInfo()
            .flatMap { (response) in
                return Single.just(response)
            }
        
        return observable
    }
    
}// class
