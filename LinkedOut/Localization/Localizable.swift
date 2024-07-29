//
//  Localizable.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import Localize_Swift

public protocol Localizable {
    var localized: String { get }
}


/// self 가 문자열이고 RawRepresentable을 따르는 경우에만 확장을 확장합니다. 열거는 기본적으로 이 프로토콜을 따릅니다.
/// 이 방법을 사용하면 열거 형에 테이블 이름만 지정해야 합니다. 프로토콜 확장에서 계산이 수행됩니다.
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
     public var localized: String {
        let localized = rawValue
             .getLocalized(in: Bundle.myMain)
        .replacingOccurrences(of: "%s", with: "%@")
        .replacingOccurrences(of: "[팝업]", with: "")

        log.debug("Localizable: \(localized)")
        
        return localized + " "
        
//        if localized.contains("\n") {
//            return localized + "\n"
//        }
//
//        return localized + "\n\n"
    }
}

public extension String {

    func getLocalized(in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: /*Localize.currentLanguage()*/ Localization.getLocaleStringCode() , ofType: "lproj"),
            let bundle = Bundle(path: path) {
            let localizedStr = bundle.localizedString(forKey: self, value: nil, table: nil)
            return localizedStr
        }
        return self
    }
}





/*
 * 사용자가 직접 언어를 바꾸는 경우에 대해서는 대응이 안 되어 사용 보류(시스템 언어만 대응 가능)
 * 사용하려면 Bundle을 동적으로 변경해줘야 한다.
 * https://medium.com/@marcosantadev/app-localization-tips-with-swift-4e9b2d9672c9
 
extension String {
    //func localized(bundle: Bundle = Bundle.myMain, tableName: String = "Localizable") -> String {
    func localized(bundle: Bundle = Bundle.myMain, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

public protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

/// self가 문자열이고 RawRepresentable을 따르는 경우에만 확장을 확장합니다. 열거는 기본적으로 이 프로토콜을 따릅니다.
/// 이 방법을 사용하면 열거 형에 테이블 이름만 지정해야 합니다. 프로토콜 확장에서 계산이 수행됩니다.
extension Localizable where Self: RawRepresentable, Self.RawValue == String {
     public var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
*/

/** Usage
enum DataLoaderStrings: String, Localizable {
    case loadingData = "loading_data"
    case dataLoaded = "data_loaded"
    
    var tableName: String {
        return "DataLoader"
    }
}
*/

