//
//  SentenceView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/9/24.
//

import UIKit
import ReactorKit
import SnapKit

public class SentenceView: BaseView {
    
    // MARK: Constant
    
    fileprivate struct Constant {
        static let essayRandomCell = "essayRandomCell"
        
        static let title = "한 문장을 모아"
        static let subTitle = "글의 시작을 알리는 문장들을 만나보세요."
    }
    
    // MARK: Metric
    
    public struct Metric {
        static let borderHeight = 4.f
        
        static let sectionLineSpacing = 0.f
        static let sectionInsetLeftRight = 20.f
        static let sectionInteritemSpacing = 0.f
        
        static let contentSideMargin = 20.f
        static let contentBottomMargin = 10.f
        
        static let titleTopMargin = 26.f
        static let listTopMargin = 22.f
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title: UIFont = .systemFont(ofSize: 16.0, weight: .semibold)
    }
    
}
