//
//  TemplateReactor.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/07.
//  Copyright © 2020 정윤호. All rights reserved.
//


import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import Moya


public final class RootReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case checkStatus
        case setInit
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        case setNextPage
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    fileprivate let authViewModel: AuthViewModelType
    fileprivate let userViewModel: UsersViewModelType
    
    // MARK: Initialize
    
    public init (
        authViewModel: AuthViewModelType,
        userViewModel: UsersViewModelType
    ) {
        self.authViewModel = authViewModel
        self.userViewModel = userViewModel
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
            case .setInit:
            return userViewModel
                .getUserInfo()
                .asObservable()
                .map { response in
                    print(response)
                    MyInfoManager.shared.myInfo = response.data
                    SceneDelegate.shared.router.routeMainTabBar()
                    return .setNextPage
                }
                .catch { (error) in
                    return .just(.setError(makeError(LinkedOutError(error))))
                }
            case .checkStatus:
            return authViewModel
                .getHealthcheck()
                .asObservable()
                .map { response in
                    print(response)
                    SceneDelegate.shared.router.routeMainTabBar()
                    return .setNextPage
                }
                .catch { (error) in
                    return .just(.setError(makeError(LinkedOutError(error))))
                }
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: RootReactor.State,
        mutation: RootReactor.Mutaion
    ) -> RootReactor.State {
        
        var newState = state
        
        switch mutation {
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            case .setNextPage:
                return newState
        }// switch
    }// reduce
}// class
