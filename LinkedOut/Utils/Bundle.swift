//
//  Bundle.swift
//  LinkedOut
//
//  Created by 이상하 on 7/26/24.
//

import Foundation

extension Bundle {
    class var myMain: Bundle {
        get { return Bundle(for: ViewController.self) }
//        get { return Language.getBundle() }
    }
    
    var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
