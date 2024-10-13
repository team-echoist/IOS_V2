//
//  DependenciesViewController.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import UIKit

extension Dependencies: DependenciesViewControllerType {
    
    public func makeRoot() -> UIViewController {
        return RootViewController(reactor: self.makeRoot())
    }
    
    
    public func makeMain() -> UIViewController {
        return HomeViewController(reactor: makeMain())
    }
    
    public func makeMainTabBar() -> UIViewController {
        return MainTabBarViewController(reactor: makeMainTabBar())
    }
    
    public func makeWriting() -> UIViewController {
        let imageOptions: ImageOptions = []
        return WritingViewController(
            reactor: makeWriting(),
            cellDependency: EssayViewCell.Dependency(imageOptions: imageOptions)
        )
    }
    
    public func makeComunity() -> UIViewController {
        return ComunityViewController(reactor: makeComunity())
    }
    
    public func makeMyPage() -> UIViewController {
        return MyPageViewController(reactor: self.makeMyPage())
    }
    
    public func makeEssayDetail(essayId: Int) -> UIViewController {
        return EssayDetailViewController(
            reactor: self.makeEssayDetail(),
            essayId: essayId
        )
    }
    
    public func makeEssayCreate() -> UIViewController {
        return EssayCreateViewController(
            reactor: self.makeEssayCreate()
        )
    }
    
    public func makeLogin() -> UIViewController {
        return LoginViewController(reactor: self.makeLogin())
    }
}
