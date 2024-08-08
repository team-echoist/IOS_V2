//
//  EssayRandomSection.swift
//  LinkedOut
//
//  Created by 이상하 on 8/8/24.
//

import RxDataSources

public enum EssayRandomSection {
    case items([EssayRandomItem])
}

public enum EssayRandomItem {
    case essayRandomViewCellReactor(EssayRandomViewCellReactor)
}

extension EssayRandomSection: SectionModelType {
        
    public var items: [EssayRandomItem] {
        switch self {
            case .items(let items): return items
        }
    }
    
    public init(original: EssayRandomSection, items: [EssayRandomItem]) {
        switch original {
            case .items: self = .items(items)
        }
    }
}

