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


public final class ComunityReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        case inputRefresh
        case loadPage
        
        case inputSelectedTab(ComunityTabType)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setRefresh
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        
        case setSelectedTab(ComunityTabType)
        case appendEssays([Essay])
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        
        public var selectedTab: ComunityTabType = .random
        public var essayList: [EssayRandomSection] = [.items([])]
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    fileprivate let essayViewModel: EssayViewModelType
    
    // MARK: Factory
    
    public let randomCellReactorFactory: (Essay) -> EssayRandomViewCellReactor
    
    // MARK: Initialize
    
    public init(
        essayViewModel: EssayViewModelType,
        randomCellReactorFactory: @escaping (Essay) -> EssayRandomViewCellReactor
    ) {
        self.essayViewModel = essayViewModel
        self.randomCellReactorFactory = randomCellReactorFactory
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
        case .inputRefresh:
            return self.getEssayList(start: self.startLoading, end: self.endLoading)
        case .loadPage:
            return self.getEssayList(start: self.startLoading, end: self.endLoading)
        case .inputSelectedTab(let tab):
            return .just(.setSelectedTab(tab))
        }
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: ComunityReactor.State,
        mutation: ComunityReactor.Mutaion
    ) -> ComunityReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            
            case .setRefresh:
                return newState
            case let .setSelectedTab(tab): newState.selectedTab = tab; return newState
            case let .appendEssays(essays):
                let sectionItems = newState.essayList[0].items + self.getRandomEssaySectionItems(with : essays)
                newState.essayList = [.items(sectionItems)]
                return newState
        }
    }
    
    // MARK: Fetch
    
    private func getEssayList(
        start: Observable<Mutation>,
        end: Observable<Mutation>
    ) -> Observable<Mutation> {
        guard !self.currentState.isLoading else { return .empty() }
        
        let action = self.essayViewModel
            .getEssayRecommend(limit: nil)
            .asObservable()
            .map { (response) -> ComunityReactor.Mutaion in
                return self.getEssayData(response)
            }
            .catch { (error) in
                return .just(.setError(makeError(LinkedOutError(error))))
            }
            .debug()
        
        return .concat([start, action, end])
    }
    
    private func getEssayData(_ response: ApiResult<EssayNonePagingArray>) -> ComunityReactor.Mutaion {
        if let items = response.data?.essays, items.count > 0 {
            return .appendEssays(items)
        }
        
        return .appendEssays([])
    }
    
    // MARK: Section
    
    private func getRandomEssaySectionItems(with essays: [Essay]) -> [EssayRandomItem] {
        let items = essays
            .map(self.randomCellReactorFactory)
            .map(EssayRandomItem.essayRandomViewCellReactor)
        return items
    }
}
