//
//  Environment.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL = "Root_Url"
            static let amplitudeKey = "Amplitude Key"
            static let eventWebUrl = "Event Web Url"
            static let deeplinkPrefix = "DeepLink_Prefix"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let rootURL: String = {
//        guard let rootURLstring = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
//            fatalError("Root URL not set in plist for this environment")
//        }
//        
//        return rootURLstring
        return "https://linkedoutapp.com/api/"
    }()

    static let amplitudeKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.amplitudeKey] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let eventWebUrl: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.eventWebUrl] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return url
    }()
    
    static let deeplinkPrefix: String = {
        guard let url = Environment.infoDictionary[Keys.Plist.deeplinkPrefix] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return url
    }()
}

