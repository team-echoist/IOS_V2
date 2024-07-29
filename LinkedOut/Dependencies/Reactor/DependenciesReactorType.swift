//
//  DependenciesReactorType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


public protocol DependenciesReactorType {
    func makeMain() -> MainReactor
    func makeMainTabBar() -> MainTabBarReactor
    func makeWriting() -> WritingReactor
}
