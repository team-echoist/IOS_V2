//
//  TermsAgreeButtonReactor.swift
//  LinkedOut
//
//  Created by 이상하 on 11/1/24.
//

import ReactorKit

class TermsAgreeButtonReactor: Reactor {
    
    public enum Action {
        case toggleAgreeButton(Bool)
        case inputInfo
    }
    
    public enum Mutaion {
        case setAgreeSelected(Bool)
    }
    
    // MARK: State
    
    public struct State {
        public let termsData: SignupTermsModel.TermsData
        public var isSelected: Bool = false
        public let hasLink: Bool
        public let title: String
    }
    
    public let initialState: State
    
    // MARK: Initialize

    public init(termsData: SignupTermsModel.TermsData) {
        let hasLink = termsData.link != nil
        let requiredText = termsData.required ? "필수" : "선택"
        let title = "(\(requiredText)) \(termsData.content)"
        self.initialState = State(termsData: termsData, hasLink: hasLink, title: title)
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .toggleAgreeButton(let selected):
            return .just(.setAgreeSelected(selected))
        case .inputInfo:
            if let url = self.initialState.termsData.link {
                SceneDelegate.shared.router.routeToWeburl(url: url)
            }
            return .empty()
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: TermsAgreeButtonReactor.State,
        mutation: TermsAgreeButtonReactor.Mutaion
    ) -> TermsAgreeButtonReactor.State {
        var newState = state
        
        switch mutation {
        case let .setAgreeSelected(selected):
            newState.isSelected = selected
            return newState
        }
    }
}
