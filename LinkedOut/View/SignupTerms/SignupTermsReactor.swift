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


public final class SignupTermsReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputAllAgree
        case inputAgree(SignupTermsModel.TermsType)
        case inputNext
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        
        case setAllTermsData
        case setTermsData(SignupTermsModel.TermsType)
//        case setNextButtonEnabled(Bool)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        
        public var isAllAgree: Bool = false
        public var termsDatas: [SignupTermsModel.TermsData] = SignupTermsModel.geratedTermsData()
        public var nextButtonEnabled: Bool = false
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    
    // MARK: Initialize
    
    public init() {
        
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .inputAllAgree:
            return .just(.setAllTermsData)
        case .inputAgree(let termsType):
            return .just(.setTermsData(termsType))
        case .inputNext:
            
            return .empty()
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: SignupTermsReactor.State,
        mutation: SignupTermsReactor.Mutaion
    ) -> SignupTermsReactor.State {
        
        var newState = state
        
        switch mutation {
            
        case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
        case let .setError(error): newState.error = error; return newState
        case let .setAlert(alert): newState.alert = alert; return newState
        case let .setMessage(message): newState.message = message; return newState
        case .setAllTermsData:
            let targetSelected = !newState.isAllAgree
            let data = newState.termsDatas.map {
                var newItem = $0
                newItem.selected = targetSelected
                
                return newItem
            }
            
            newState.isAllAgree = targetSelected
            newState.termsDatas = data
                        
            return newState
        case let .setTermsData(termsType):
            let data = newState.termsDatas.map {
                var newItem = $0
                if $0.type == termsType {
                    newItem.selected = !$0.selected
                }
                
                return newItem
            }
            newState.isAllAgree = data.allSatisfy { $0.selected || $0.required == false }
            newState.termsDatas = data
            
            return newState
        }// switch
    }// reduce
}// class
