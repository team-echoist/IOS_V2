//
//  EssayViewCellReactor.swift
//  LinkedOut
//
//  Created by 이상하 on 8/1/24.
//

import ReactorKit
import RxCocoa
import RxSwift

public class EssayViewCellReactor: Reactor {
    
    // MARK: Action
    
    public enum Action {
        case inputTapEssay
    }
    
    // MARK: Mutation
    
    public enum Mutation {
        case setTapEssay
    }
    
    // MARK: State
    
    public struct State {
        public var id: Int
        public var createdDate: String
        public var title: String
        public var content: String
        public var thumbnail: String?
    }
    
    public var initialState: State
    
    public init(essayData: Essay) {
        
        self.initialState = State(
            id: essayData.id,
            createdDate: essayData.createdDate.changeDateStringFormat(),
            title: essayData.title,
            content: essayData.content,
            thumbnail: essayData.thumbnail
        )
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputTapEssay:
            return .just(.setTapEssay)
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: EssayViewCellReactor.State,
        mutation: EssayViewCellReactor.Mutation)
    -> EssayViewCellReactor.State {
        var newState = state
        
        switch mutation {
            
        case .setTapEssay:
            return newState
        }
        
    }
    
}
