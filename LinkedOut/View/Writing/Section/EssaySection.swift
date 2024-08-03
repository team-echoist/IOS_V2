//
//  EssaySection.swift
//  LinkedOut
//
//  Created by 이상하 on 8/2/24.
//

import RxDataSources

public enum EssaySection {
    case items([EssayItem])
}

public enum EssayItem {
    case essayViewCellReactor(EssayViewCellReactor)
}

extension EssaySection: SectionModelType {
        
    public var items: [EssayItem] {
        switch self {
            case .items(let items): return items
        }
    }
    
    public init(original: EssaySection, items: [EssayItem]) {
        switch original {
            case .items: self = .items(items)
        }
    }
}

