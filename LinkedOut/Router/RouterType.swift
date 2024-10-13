//
//  RouterType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/19.
//  Copyright © 2020 정윤호. All rights reserved.
//

import UIKit

public typealias RouteCompletionHandler = () -> Void

public enum RouterMethod {
    case push
    case present
}

public protocol RouterType {
    
    func routeBack(animated: Bool)
    func routeDismiss(animated: Bool, completionHandler: RouteCompletionHandler?)
    func routeHomeView()
    func getHomeView() -> UIViewController
    func routeMainTabBar()
    func routeWriting()
    func getWriting() -> UIViewController
    func routeComunity()
    func getComunity() -> UIViewController
    func routeProfile()
    func getMyPage() -> UIViewController
    func routeEssayDetail(essayId: Int)
    func routeEssayCrate()
    // MARK: - Login
    func routeLogin()
}
