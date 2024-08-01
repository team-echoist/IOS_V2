//
//  DependenciesRepositoryType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


public protocol DependenciesRepositoryType { 

    func makeAuth() -> AuthRepository
    func makeEssay() -> EssayRepository
}
