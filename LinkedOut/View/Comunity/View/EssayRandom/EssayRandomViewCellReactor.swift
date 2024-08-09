//
//  EssayRandomViewCellReactor.swift
//  LinkedOut
//
//  Created by 이상하 on 8/8/24.
//

import ReactorKit
import RxCocoa
import RxSwift

public class EssayRandomViewCellReactor: Reactor {
    
    // MARK: Constant
    
    public struct Constant {
        static let createDateOriginFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        static let createDateTargetFormat = "yyyy년 MM월 dd일 HH:mm"
    }
    
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
        public var authorNickname: String?
    }
    
    public var initialState: State
    
    public init(essayData: Essay) {
        
        self.initialState = State(
            id: essayData.id,
            createdDate: "· " + essayData.createdDate
                            .changeDateStringFormat(
                                dateFormat: Constant.createDateOriginFormat,
                                changeForamt: Constant.createDateTargetFormat
                            ),
            title: essayData.title,
            content: essayData.content,
            thumbnail: essayData.thumbnail,
            authorNickname: essayData.author?.nickname
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
        state: EssayRandomViewCellReactor.State,
        mutation: EssayRandomViewCellReactor.Mutation)
    -> EssayRandomViewCellReactor.State {
        var newState = state
        
        switch mutation {
        case .setTapEssay:
            return newState
        }
    }

    
}
