//
//  Appstorage.swift
//  foodinko
//
//  Created by Kevin Lee on 2023/04/17.
//  Copyright © 2023 Foodinko. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let appStorage = try AppStorage(json)

import Foundation
import SwiftKeychainWrapper

// MARK: - Appstorage
public struct Appstorage: Codable {
    var targetLanguage: String?
    var deviceID: String?
    
    // Constants
    enum Constant {
        static let fdkoDeviceId = "FdkoDeviceId"
    }

    enum CodingKeys: String, CodingKey {
        case targetLanguage
        case deviceID = "deviceId"
    }
        
}

// MARK: Appstorage convenience initializers and mutators

extension Appstorage {
    public init(data: Data) throws {
        self = try newJSONDecoder().decode(Appstorage.self, from: data)
    }

    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    public init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    public func with(
        targetLanguage: String?? = nil,
        deviceID: String?? = nil
    ) -> Appstorage {
        return Appstorage(
            targetLanguage: targetLanguage ?? self.targetLanguage,
            deviceID: deviceID ?? self.deviceID
        )
    }

    public func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    public func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UserConfig
public struct UserConfig: Codable {
}

// MARK: UserConfig convenience initializers and mutators

extension UserConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UserConfig.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
    ) -> UserConfig {
        return UserConfig(
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


