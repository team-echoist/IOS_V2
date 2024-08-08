//
//  ComunityTabModel.swift
//  LinkedOut
//
//  Created by 이상하 on 8/6/24.
//

import Foundation

public struct ComunityTabModel {
    
    let tabType: WritingTabType
    let title: String
}

public enum ComunityTabType: String {
    case random = "랜덤"
    case bookmarked = "저장"
}
