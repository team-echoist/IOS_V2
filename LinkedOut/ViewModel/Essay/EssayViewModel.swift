// 
//  EssayViewModel.swift
//  LinkedOut
//
//  Created by 이상하 on 7/31/24.
//

import RxSwift

public class EssayViewModel: BaseViewModel, EssayViewModelType {
    
    /// Repository
    fileprivate let essayRepository: EssayRepositoryType

    // MARK: Initialize
    public init(essayRepository: EssayRepositoryType) {
        self.essayRepository = essayRepository
    }
    
    public func getEssays() -> Single<ApiResult<EssayArray>> {
        let observable = self
            .essayRepository
            .getEssays()
            .flatMap { (response) in
                return Single.just(response)
            }
        return observable
    }
    
    public func postEssays() {
        
    }
    
}// class
