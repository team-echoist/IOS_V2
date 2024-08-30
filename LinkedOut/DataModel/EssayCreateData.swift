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
}
