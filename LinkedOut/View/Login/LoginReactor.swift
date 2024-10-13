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


public final class LoginReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputBack
        
        case inputShowPassword
        
        case inputLogin
        case inputAutoLogin
        case inputFindId
        case inputResetPassword
        case inputRegister
        
        case inputGoogle
        case inputKakao
        case inputNaver
        case inputApple
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        
        case toggleShowPassword
        case toggleIsAutoLogin
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        
        public var id: String = ""
        public var password: String = ""
        
        public var showPassword: Bool = false
        public var isAutoLogin: Bool = false
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    //fileprivate let someViewModel: SomeViewModelType
    
    // MARK: Initialize
    
    public init() {//(someViewModel: SomeViewModelType) {
        //self.someViewModel = someViewModel
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .inputBack:
        // TODO: go
        //AppDelegate.shared.router.back()
        return .empty()
        case .inputShowPassword:
            return .just(.toggleShowPassword)
        case .inputLogin:
            // TODO: login api 호출
            return .empty()
        case .inputAutoLogin:
            return .just(.toggleIsAutoLogin)
        case .inputFindId:
            return .empty()
        case .inputResetPassword:
            return .empty()
        case .inputRegister:
            return .empty()
        case .inputGoogle:
            return .empty()
        case .inputKakao:
            return .empty()
        case .inputNaver:
            return .empty()
        case .inputApple:
            return .empty()
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: LoginReactor.State,
        mutation: LoginReactor.Mutaion
    ) -> LoginReactor.State {
        
        var newState = state
        
        switch mutation {
            
        case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
        case let .setError(error): newState.error = error; return newState
        case let .setAlert(alert): newState.alert = alert; return newState
        case let .setMessage(message): newState.message = message; return newState
            
        case .toggleShowPassword:
            newState.showPassword = !state.showPassword
            return newState
        case .toggleIsAutoLogin:
            newState.isAutoLogin = !state.isAutoLogin
            return newState
        }// switch
    }// reduce
}// class
