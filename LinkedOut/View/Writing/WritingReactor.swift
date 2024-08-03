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


public final class WritingReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public enum Action {
        
        case refresh
        
        case inputNextPage
        case inputTab(WritingTabType)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        
        case setRefreshing(Bool)
        case appendEssays([Essay])
        case setSelectedTab(WritingTabType)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        
        public var isRefreshing: Bool = false
        public var hasNextPage: Bool = false
        public var currentPage: Int = 1
        public var endOfPage: Int = 0
        public var essayList: [EssaySection] = [.items([])]
        
        public var selectedTab: WritingTabType = .essay
        
        public var tabList: [WritingTabModel] = [
            .init(tabType: .essay, title: "나만의 글 n", selected: true),
            .init(tabType: .posted, title: "발행한 글 n", selected: false),
            .init(tabType: .story, title: "스토리 n", selected: false)
        ]
    }
    
    // MARK: State
    
    public let initialState = State()
    
    // MARK: View Model
    
    fileprivate let essayViewModel: EssayViewModelType
    // MARK: Factory
    
    public let cellReactorFactory: (Essay) -> EssayViewCellReactor
    
    // MARK: Initialize
    
    public init(
        essayViewModel: EssayViewModelType,
        cellReactorFactory: @escaping (Essay) -> EssayViewCellReactor
    ) {
        self.essayViewModel = essayViewModel
        self.cellReactorFactory = cellReactorFactory
    }
    
    // MARK: Mutate
    
    public func mutate(action: Action) -> Observable<Mutaion> {
        
        switch action {
            
        case .refresh:
            return self.getEssayList(start: self.startLoading, pageNum: 1, pageSize: 10, end: self.endLoading)
        case .inputNextPage:
            return .just(.appendEssays([]))
        case .inputTab(let selectedTab):
            return .just(.setSelectedTab(selectedTab))
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: WritingReactor.State,
        mutation: WritingReactor.Mutaion
    ) -> WritingReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            case let .setRefreshing(isRefreshing):
                newState.isRefreshing = isRefreshing
                return newState
            
            case let .appendEssays(essays):
            let sectionItems = newState.essayList[0].items + self.getSectionItems(with : essays)
            newState.essayList = [.items(sectionItems)]
                return newState
            case let .setSelectedTab(selectedTab): newState.selectedTab = selectedTab; return newState
            
        }// switch
    }// reduce
    
    // MARK: Fetch
    
    private func getEssayList(
        start: Observable<Mutation>,
        pageNum: Int,
        pageSize: Int,
        end: Observable<Mutation>
    ) -> Observable<Mutation> {
        guard !self.currentState.isRefreshing else { return .empty() }
        guard !self.currentState.isLoading else { return .empty() }
        
        let action = self.essayViewModel
            .getEssays()
            .asObservable()
            .map { (response) -> WritingReactor.Mutaion in
                return self.getEssayData(response)
            }
            .catch { (error) in
                return .just(.setError(makeError(LinkedOutError(error))))
            }
            .debug()
        
        return .concat([start, action, end])
    }
    
    private func getEssayData(_ response: ApiResult<EssayArray>) -> WritingReactor.Mutaion {
        if let items = response.data?.essays, items.count > 0 {
            return .appendEssays(items)
        }
        
        return .appendEssays([])
    }
    
    // MARK: Section
    
    private func getSectionItems(with essays: [Essay]) -> [EssayItem] {
        let items = essays
            .map(self.cellReactorFactory)
            .map(EssayItem.essayViewCellReactor)
        log.debug("items: \(items)")
        return items
    }
    
    
}// class
