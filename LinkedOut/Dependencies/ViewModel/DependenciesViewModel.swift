//
//  DependenciesViewModel.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


extension Dependencies: DependenciesViewModelType {

    public func makeAuth() -> AuthViewModel {
        if self.authViewModel == nil {
            self.authViewModel = AuthViewModel(authRepository: self.makeAuth())
        }
        
        return self.authViewModel!
    }
    
    public func makeUser() -> UsersViewModel {
        if self.userViewModel == nil {
            self.userViewModel = UsersViewModel(userRepository: self.makeUser())
        }
        
        return self.userViewModel!
    }
    
    public func makeEssay() -> EssayViewModel {
        if self.essayViewModel == nil {
            self.essayViewModel = EssayViewModel(essayRepository: self.makeEssay())
        }
        
        return self.essayViewModel!

    }

}
