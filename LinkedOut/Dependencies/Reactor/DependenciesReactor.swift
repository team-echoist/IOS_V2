//
//  DependenciesReactor.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/22.
//  Copyright © 2020 Foodinko. All rights reserved.
//


extension Dependencies: DependenciesReactorType {
    
    public func makeRoot() -> RootReactor {        
        return RootReactor(
            authViewModel: self.makeAuth(), 
            userViewModel: self.makeUser()
        )
    }
    
    public func makeMain() -> HomeReactor {
        return HomeReactor()
    }
    
    public func makeMainTabBar() -> MainTabBarReactor {
        return MainTabBarReactor()
    }
    
    public func makeWriting() -> WritingReactor {
        return WritingReactor(
            essayViewModel: self.makeEssay(),
            cellReactorFactory: EssayViewCellReactor.init
        )
    }
    
    public func makeComunity() -> ComunityReactor {
        return ComunityReactor(
            essayViewModel: self.makeEssay(),
            randomCellReactorFactory: EssayRandomViewCellReactor.init
        )
    }
    
    public func makeMyPage() -> MyPageReactor {
        return MyPageReactor(
            essayViewModel: self.makeEssay(),
            userViewModel: self.makeUser()
        )
    }
    
    public func makeEssayDetail() -> EssayDetailReactor {
        return EssayDetailReactor()
    }
}
