//
//  Localization.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import SwiftyUserDefaults


// MARK: Keys

public enum LocaleReplacing: String {
    case variable = "[var]"
}

// MARK: DefaultsKeys

extension DefaultsKeys {
    
    /// 국가 코드
    //var locale: DefaultsKey<String?> { return .init("locale") }
    
}


// MARK: Localize Strings

public enum LocalizeString: String, Localizable {
    case ok = "ok"
    case cancel = "cancel"
    case yes = "yes"
    case no = "no"
}


// MARK: Calendar
enum CalendarEng: String {
    static let allValues = [january, february, march, april, may, june, july, august, september, october, november, december]

    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
}


// MARK: Localization

public protocol LocalizationType {
    
}// protocol

public final class Localization: LocalizationType {
    
}// class

extension Localization {
    /// 설정된 국가 string 코드
    class func getLocaleStringCode() -> String {
//        guard let locale = Defaults.locale else {
//            let languageCode = Locale.current.languageCode
//            Defaults.locale = languageCode//LocaleSystem.ko.rawValue
//            log.debug("saved default locale: \(Defaults.locale)")
//            return Defaults.locale!
//        }
//        return locale
        return ""
    }
}// extension
