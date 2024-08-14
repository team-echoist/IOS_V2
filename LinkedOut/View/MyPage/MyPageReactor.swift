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


public final class MyPageReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case onTapListItem(MyPageModel.ListItem)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
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
    
    fileprivate let essayViewModel: EssayViewModelType
    fileprivate let userViewModel: UsersViewModelType
    
    // MARK: Initialize
    
    public init(
        essayViewModel: EssayViewModelType,
        userViewModel: UsersViewModelType
    ) {
        self.essayViewModel = essayViewModel
        self.userViewModel = userViewModel
        
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .onTapListItem(let listItem):
            switch listItem {
            case .badge:
                break
            case .recent:
                break
            case .membership:
                break
            case .account:
                break
            }
            return .empty()

        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: MyPageReactor.State,
        mutation: MyPageReactor.Mutaion
    ) -> MyPageReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            
        }// switch
    }// reduce
}// class
