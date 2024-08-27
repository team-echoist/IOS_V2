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


public final class EssayCreateReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputCancel
        case inputSave
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizedError>?)
        case setMessage(Tracked<String>?)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizedError>?
        public var message: Tracked<String>?
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    fileprivate let essayViewModel: EssayViewModelType
    
    // MARK: Initialize
    
    public init(essayViewModel: EssayViewModelType) {
        self.essayViewModel = essayViewModel
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .inputCancel:
            SceneDelegate.shared.router.routeDismiss(animated: true, completionHandler: nil)
            return .empty()
        case .inputSave:
            return .empty()
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: EssayCreateReactor.State,
        mutation: EssayCreateReactor.Mutaion
    ) -> EssayCreateReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            
        }// switch
    }// reduce
}// class
