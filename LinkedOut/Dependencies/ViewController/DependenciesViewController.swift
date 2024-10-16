//
//  DependenciesViewController.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import UIKit

extension Dependencies: DependenciesViewControllerType {
    
    public func makeMain() -> UIViewController {
        return MainViewController(reactor: makeMain())
    }
    
    public func makeMainTabBar() -> UIViewController {
        return MainTabBarViewController(reactor: makeMainTabBar())
    }
    
    public func makeWriting() -> UIViewController {
        return WritingViewController(reactor: makeWriting())
    }
}
