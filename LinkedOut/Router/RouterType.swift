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
    func routeMainView()
    
    func routeHomeView()
    func getHomeView() -> UIViewController
    func routeMainTabBar()
    func routeWriting()
    func getWriting() -> UIViewController
    func routeComunity()
    func routeProfile()
}
