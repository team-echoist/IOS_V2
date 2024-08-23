//
//  DependenciesViewControllerType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import UIKit


public protocol DependenciesViewControllerType {
    func makeRoot() -> UIViewController
    func makeMain() -> UIViewController
    func makeMainTabBar() -> UIViewController
    func makeWriting() -> UIViewController
    func makeComunity() -> UIViewController
    func makeMyPage() -> UIViewController
    func makeEssayDetail(essayId: Int) -> UIViewController
    // TODO : 임시저장 Id 불러와서 데이터 세팅하게끔 파라미터 추가, tempSaveId
    func makeEssayCreate() -> UIViewController
}
