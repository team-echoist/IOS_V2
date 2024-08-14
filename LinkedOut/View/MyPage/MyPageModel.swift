//
//  TemplateModel.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/09.
//  Copyright © 2020 정윤호. All rights reserved.
//

import Foundation

public struct MyPageModel: ModelType {
    
    enum Event {
        
    }
    
    public enum ListItem: String, CaseIterable {
        case badge = "링크드아웃 뱃지"
        case recent = "최근 본 글"
        case membership = "멤버쉽 관리"
        case account = "계정 관리"
    }
    
}
