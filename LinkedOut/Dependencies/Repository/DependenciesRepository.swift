//
//  DependenciesRepository.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


extension Dependencies: DependenciesRepositoryType {
    
    public func makeAuth() -> AuthRepository {
        if self.authRepository == nil {
            self.authRepository = AuthRepository(dependencies: self)
        }
        
        return self.authRepository!
    }
}
