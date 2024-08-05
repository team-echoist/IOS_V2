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
    
    public func makeUser() -> UsersRepository {
        if self.userRepository == nil {
            self.userRepository = UsersRepository(dependencies: self)
        }
        
        return self.userRepository!
    }
    
    public func makeEssay() -> EssayRepository {
        if self.essayRepository == nil {
            self.essayRepository = EssayRepository(dependencies: self)
        }
        
        return self.essayRepository!
    }
}
