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


public final class EssayDetailReactor: Reactor {
    
    
    private let startLoading = Observable<Mutation>.just(.setLoading(true))
    private let endLoading = Observable<Mutation>.just(.setLoading(false))
    
    public struct Constant {
        static let createDateOriginFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        static let createDateTargetFormat = "yyyy년 MM월 dd일 HH:mm"
    }
    
    public enum Action {
        case inputBack
        case loadEssay(Int)
    }
    
    public enum Mutaion {
        case setLoading(Bool)
        case setError(Tracked<LinkedOutError>?)
        case setAlert(Tracked<LocalizeString>?)
        case setMessage(Tracked<String>?)
        case setEssay(EssayDetail?)
    }
    
    public struct State {
        public var isLoading: Bool = false
        public var error: Tracked<LinkedOutError>?
        public var alert: Tracked<LocalizeString>?
        public var message: Tracked<String>?
        public var hasImage: Bool = false
        public var essay: EssayDetail?
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
        case .inputBack:
            SceneDelegate.shared.router.routeBack(animated: true)
            return .empty()
        case .loadEssay(let essayId):
            return self.getEssayDetail(start: self.startLoading, essayId: essayId, essayType: .recommend, end: self.endLoading)
        }
        
    }
    
    // MARK: Reduce
    
    public func reduce(
        state: EssayDetailReactor.State,
        mutation: EssayDetailReactor.Mutaion
    ) -> EssayDetailReactor.State {
        
        var newState = state
        
        switch mutation {
            
            case let .setLoading(isLoading): newState.isLoading = isLoading; return newState
            case let .setError(error): newState.error = error; return newState
            case let .setAlert(alert): newState.alert = alert; return newState
            case let .setMessage(message): newState.message = message; return newState
            case let .setEssay(essay):
            // 생성일 converting
            var essayDetail = essay
            if let _ = essayDetail {
                essayDetail!.createdDate = essayDetail!.createdDate.changeDateStringFormat(
                    dateFormat: Constant.createDateOriginFormat,
                    changeForamt: Constant.createDateTargetFormat
                )
            }
            
            newState.essay = essayDetail;
            return newState
        }
    }
        
    // MARK: Fetch
    
    private func getEssayDetail(
        start: Observable<Mutaion>,
        essayId: Int,
        essayType: EssayType,
        end: Observable<Mutaion>
    ) -> Observable<Mutaion> {
        guard !self.currentState.isLoading else { return .empty() }
        
        let action = self.essayViewModel
            .getEssayDetail(essayId: essayId, type: essayType)
            .asObservable()
            .map { (response) -> Mutaion in
                return self.getEssayDetailData(response)
            }
            .catch { (error) in
                log.error(error)
                return .just(.setError(makeError(LinkedOutError(error))))
            }
        
        return .concat([start, action, end])
    }
    
    private func getEssayDetailData(_ response: ApiResult<EssayDetailResponse>) -> Mutaion {
        if let item = response.data?.essay {
            return .setEssay(item)
        }
        
        return .setEssay(nil)
    }
}
