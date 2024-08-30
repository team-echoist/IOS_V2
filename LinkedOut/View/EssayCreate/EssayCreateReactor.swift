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
        case inputTitleField(String)
        case inputContentField(NSAttributedString)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizedError>?)
        case setMessage(Tracked<String>?)
        
        case setTitleField(String)
        case setContentField(NSAttributedString)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizedError>?
        public var message: Tracked<String>?
        
        public var title: String = ""
        public var content: String = ""
        public var status: EssayStatus?
        public var latitude: Double?
        public var logintude: Double?
        public var thumbnail: String?
        public var location: String?
        public var tags: [String]?
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
            log.debug("inputSave")
            log.debug(self.currentState.content)
            return .empty()
        case .inputTitleField(let title):
            return .just(.setTitleField(title))
        case .inputContentField(let content):
            return .just(.setContentField(content))
            
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
            
            case let .setTitleField(title): newState.title = title; return newState
            case let .setContentField(content): 
                let htmlData = try? content.data(from: NSRange(location: 0, length: content.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.html])
                let htmlString = String(data: htmlData!, encoding: .utf8)
                newState.content = htmlString ?? ""
                return newState
        }
    }
}
