//
//  TemplateModel.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/09.
//  Copyright © 2020 정윤호. All rights reserved.
//

import Foundation

public struct WritingModelModel: ModelType {
    
    enum Event {
        
    }
    
}

/*
 {
     "id": 2296,
     "createdDate": "2024-07-31T11:36:28.539+09:00",
     "status": "private",
     "thumbnail": null,
     "title": "에베베벱",
     "content": "나는 작성 잘 되눈뎅~",
     "author": {
       "id": 2,
       "email": "user1@linkedoutapp.com",
       "nickname": "영어싫음",
       "profileImage": "https://driqat77mj5du.cloudfront.net/profile/44f27762-de56-4538-a989-55ecd473f467",
       "createdDate": "2024-05-09T00:53:24.594Z",
       "marketingConsent": false, -> 안씀
       "locationConsent": false -> 안씀
     }
}
 */
public struct EssayArray: Codable {
    public var essays: [Essay]
    public var total: Int
    public var totalPage: Int
    public var page: Int
}

public struct EssayNonePagingArray: Codable {
    let essays: [Essay]
}

public struct Essay: Codable {
    
    let id: Int
    let createdDate, status: String
    let thumbnail: String?
    let title, content: String
    let author: Author?
}

public struct EssayDetailResponse: Codable {
    
    let essay: EssayDetail
    let anotherEssays: AnotherEssayResponse?
        
}

public struct AnotherEssayResponse: Codable {
    let essays: [Essay]?
}

public enum EssayStatus: String {
    case privateStaus = "private"
    case published = "published"
    case linkedout = "linkedout"
    
    static func getEssayStatus(_ string: String) -> EssayStatus {
        switch string {
        case EssayStatus.privateStaus.rawValue:
            return .privateStaus
        case EssayStatus.published.rawValue:
            return .published
        case EssayStatus.linkedout.rawValue:
            return .linkedout
        default:
            return .published
        }
    }
}

public struct EssaySentenceArray: Codable {
    let essays: [EssaySentence]
}

public struct EssaySentence: Codable {
    let id: Int
    let content: String
    let status: String
    let createdDate: String
}

public struct Author: Codable {
    let id: Int
    var email, createdDate: String
    let nickname: String?
    let profileImage: String?
}
