//
//  HomeViewModelType.swift
//  LinkedOut
//
//  Created by 이상하 on 7/30/24.
//

import RxSwift

public protocol AuthViewModelType {
    
    func getHealthcheck() -> Single<ApiWebResult>
}
