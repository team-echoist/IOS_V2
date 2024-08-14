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
    
    // MARK: Constant
    
    public struct Constant {
        static let createDateOriginFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        static let createDateTargetFormat = "yyyy년 MM월 dd일 HH:mm"
    }
    
    // MARK: Action
    
    public enum Action {
        case inputTapEssay(essayId: Int)
    }
    
    // MARK: Mutation
    
    public enum Mutation {
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
            createdDate: essayData.createdDate
                            .changeDateStringFormat(
                                dateFormat: Constant.createDateOriginFormat,
                                changeForamt: Constant.createDateTargetFormat
                            ),
            title: essayData.title,
            content: essayData.content + "...",
            thumbnail: essayData.thumbnail
        )
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputTapEssay(let essayId):
            SceneDelegate.shared.router.routeEssayDetail(essayId: essayId)
            return .empty()
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: EssayViewCellReactor.State,
        mutation: EssayViewCellReactor.Mutation)
    -> EssayViewCellReactor.State {
        var newState = state
        
        return newState
    }
    
}
