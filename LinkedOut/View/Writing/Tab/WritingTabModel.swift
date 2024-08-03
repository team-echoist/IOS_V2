//
//  WritingTabModel.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import Foundation

public struct WritingTabModel {
    
    let tabType: WritingTabType
    let title: String
    let selected: Bool
}

public enum WritingTabType {
    case essay
    case posted
    case story
}
