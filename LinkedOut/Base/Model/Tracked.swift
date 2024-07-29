//
//  Tracked.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

/**
 * ReactorKit과 Standard MVVM(VM) 접근 방식의 가장 큰 차이점
 * VM에서 여러 스트림을 관찰하는 반면에,
 * ReactorKit은 여러 속성이 있는 단일 스트림(state)을 관찰한다.
 * 관찰자(observer)가 모든 상태 변경에 대해 실행하지 않게 하려면 distinctUntilChanged를 많이 사용해야 한다.
 *
 * 사용자의 반복되는 입력 오류, 네트워크 연결 오류 등의 반복적인 알림 메시지 노출이 필요할 경우
 * distinctUntilChanged를 사용하면 두 번째 이벤트는 실행할 수 없게 된다.
 * 1. Reactor에서 Observable을 직접 노출하거나
 * 2. 특정 state 속성을 패키징하여 변경 사항을 추적해야 한다.
 */

import Foundation
import RxSwift

public var preValue = 1

public struct Tracked<T> {
    let tracker: Int
    let value: T?
    
    public init(_ value: T?) {
        self.tracker = Int.random(in: 1...100, excluding: preValue)
        self.value = value
        //log.debug("value tracker: \(self.tracker), value: \(self.value)")
    }
}

public func makeAlert(_ alert: LocalizeString) -> Tracked<LocalizeString> {
    return Tracked(alert)
}

public func makeMessage(_ message: String) -> Tracked<String> {
    return Tracked(message)
}

public func makeError(_ error: LinkedOutError) -> Tracked<LinkedOutError> {
    return Tracked(error)
}

extension ObservableType {

    /// 직전에 방출된 이벤트와 동일 여부 확인. 다른 경우 value<T> 방출.
    public func mapChangedTracked<T> (
        _ transform: @escaping (Element) throws -> Tracked<T>)
    -> Observable<T?> {
        return self
            .map(transform)
            .distinctUntilChanged { $0.tracker == $1.tracker }
            .map { $0.value }
    }
}
