//
//  MyInfoManager.swift
//  LinkedOut
//
//  Created by 이상하 on 8/5/24.
//

import Foundation

public class MyInfoManager {
    
    static let shared = MyInfoManager()
    
    public var isLogin = false
    
    public var myInfo: UserInfoData? = nil
}
