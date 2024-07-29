//
//  RouterReactor.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/19.
//  Copyright © 2020 정윤호. All rights reserved.
//


import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import Moya


public final class RouterReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
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
        
        //switch action {}
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: RouterReactor.State,
        mutation: RouterReactor.Mutaion
    ) -> RouterReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            
        }// switch
    }// reduce
}// class
