//
//  DependenciesReactor.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


extension Dependencies: DependenciesReactorType {
    
    public func makeMain() -> HomeReactor {
        return HomeReactor()
    }
    
    public func makeMainTabBar() -> MainTabBarReactor {
        return MainTabBarReactor()
    }
    
    public func makeWriting() -> WritingReactor {
        return WritingReactor()
    }
}
