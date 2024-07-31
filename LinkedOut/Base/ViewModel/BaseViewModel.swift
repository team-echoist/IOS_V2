//
//  BaseViewModel.swift
//  LinkedOut
//
//  Created by 이상하 on 7/30/24.
//

import Foundation
import RxSwift

public protocol BaseViewModelType {
    func catchErrorJustReturn(_ result: ApiWebResult) throws
}

public class BaseViewModel: BaseViewModelType {
    public func catchErrorJustReturn(_ result: ApiWebResult) throws {
        log.debug(result)
        guard result.statusCode == 0 else {
            do { throw LinkedOutError(result) }
            catch { throw error }
        }
    }
}
