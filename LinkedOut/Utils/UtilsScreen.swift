//
//  UtilsScreen.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import UIKit

class UtilsScreen {
    
    /// 상태바
    static func getSizeStatusBar() -> CGFloat {
        var statusBarFrame: CGRect
        if #available(iOS 13.0, *){
            statusBarFrame = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        return statusBarFrame.size.height
    }
    
    static func getSizeNavigationBar() -> CGFloat {
        return 62
    }
    
    static func getSizeNavigationBarToStatusBar() -> CGFloat {
        return getSizeStatusBar() + getSizeNavigationBar()
    }
}
