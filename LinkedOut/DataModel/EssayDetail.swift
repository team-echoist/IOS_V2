//
//  EssayDetail.swift
//  LinkedOut
//
//  Created by 이상하 on 8/20/24.
//

import Foundation

public struct EssayDetail: Codable {
    
    let id: Int
    let updatedDate, status: String
    var createdDate: String
    let linkedOutGauge: Int
    let thumbnail: String?
    let title, content: String
    let latitude, longitude: Double?
    let location: String?
    let tags: [Tag]
    let author: Author?
//    let story: JSONNull?
    let isBookmarked: Bool
}

/*
 {
    "id": 64,
    "name": "무료함 그어딘가"
 }
 */
struct Tag: Codable {
    let id: Int
    let name: String
}
