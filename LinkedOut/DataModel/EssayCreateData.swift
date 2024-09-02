//
//  EssayCreateData.swift
//  LinkedOut
//
//  Created by 이상하 on 8/29/24.
//

import Foundation

public struct EssayCreateData {
    
    let title: String
    let content: String
    let status: String
    let linkedOutGauge: Int?
    let thumbnail: String?
    let latitude: Double?
    let longitude: Double?
    let location: String?
    let tags: [String]?
    
    init(title: String, content: String, status: EssayStatus) {
        self.title = title
        self.content = content
        self.status = status.rawValue
        self.linkedOutGauge = nil
        self.thumbnail = nil
        self.latitude = nil
        self.longitude = nil
        self.location = nil
        self.tags = nil
    }
}
