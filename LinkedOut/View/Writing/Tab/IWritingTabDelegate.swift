//
//  IWritingTabDelegate.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import Foundation

public protocol IWritingTabDelegate: AnyObject {
    
    func selectedWritingTab(selectedTab: WritingTabModel)
}
