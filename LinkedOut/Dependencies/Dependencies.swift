//
//  Dependencies.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/19.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import Foundation
import UIKit


// MARK: Dependencies

public class Dependencies: HasNetworking, HasPushStore, HasFileStore {
    
    // MARK: Networking
    public let networking: LinkedOutNetworking
    
    // MARK: Store
    public let pushStore: PushStoreType
    public let fileStore: FileStoreType
    
    // MARK: Repository
//    public var userRepository: UserRepository?
//    public var feedRepository: FeedRepository?
//    public var searchRepository: SearchRepository?
    
    // MARK: View Model
//    public var userViewModel: UserViewModelA?
//    public var feedViewModel: FeedViewModelA?
//    public var searchViewModel: SearchViewModel?
    
    // MARK: Model

    // MARK: Initialize
    public init(
        networking: LinkedOutNetworking = LinkedOutNetworking(),
        pushStore: PushStoreType = PushStore(),
        fileStore: FileStoreType = FileStore()
    ) {
        self.networking = networking
        self.pushStore = pushStore
        self.fileStore = fileStore
    }
    
}// Dependencies


// MARK: DependenciesType
extension Dependencies: DependenciesType {
    
    public func logout() {
//        if let repo = self.sessionRepository {
//            repo.isTemporaryPasswordNextTime = false
//
//            if let userAccount = repo.userAccount {
//                var newUserAccount = userAccount
//                if newUserAccount.isAutoLogin {
//                    newUserAccount.isAutoLogin = false
//                    newUserAccount.isSavePw = false
//                    newUserAccount.userPw = nil
//                    self.loginVideModel?.saveLogin(userAccount: newUserAccount)
//                }
//            }
//        }            
        
//        self.loginVideModel?.logout()
    }
    
}
