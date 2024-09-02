//
//  Keyboard.swift
//  LinkedOut
//
//  Created by 이상하 on 8/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

extension Reactive where Base: NotificationCenter {
    static func keyboardHeight() -> Observable<CGFloat> {
        return Observable<Notification>
            .merge(NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification))
            .compactMap { notification -> CGFloat? in
                guard let userInfo = notification.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                    return nil
                }
                let keyboardRectangle = keyboardFrame.cgRectValue
                return notification.name == UIResponder.keyboardWillHideNotification ? 0 : keyboardRectangle.height
            }
            .distinctUntilChanged()
    }
    
    static func keyboardNotification() -> Observable<(CGFloat, Bool)> {
        let willShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification -> (CGFloat, Bool) in
                let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                return (height, true)
            }
        
        let willHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { _ in (CGFloat(0), false) }
        
        return Observable.merge(willShow, willHide)
    }
}
