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


public final class MainTabBarReactor: Reactor {
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputBack
        case selectTab(BottomTab)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
//        case setError(Tracked<Error>?)
//        case setAlert(Tracked<String>?)
        case setSelectedTab(BottomTab)
        case setMessage(Tracked<String>?)   //let action = Observable<Mutaion>.just(.setMessage(makeMessage(reason)))
    }
    
    public struct State {
        public var isLoading: Bool = false
//        public var error: Tracked<Error>?
//        public var alert: Tracked<String>?
        public var selectedTab: BottomTab = BottomTab.home
        public var message: Tracked<String>?
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
            case .selectTab(let tab):
                return .just(.setSelectedTab(tab))
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: MainTabBarReactor.State,
        mutation: MainTabBarReactor.Mutaion
    ) -> MainTabBarReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setSelectedTab(tab): newState.selectedTab = tab; return newState
//            case let .setError(error): newState.error = error; return newState
//            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            
        }// switch
    }// reduce
}// class
