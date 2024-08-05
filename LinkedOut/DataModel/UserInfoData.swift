//
//  UserInfoData.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import Foundation

public struct UserInfoData: Codable {
    
    /*         
    "data": {
        "id": 2,
        "email": "user1@linkedoutapp.com",
        "nickname": "영어싫음",
        "profileImage": "https://driqat77mj5du.cloudfront.net/profile/44f27762-de56-4538-a989-55ecd473f467",
        "createdDate": "2024-05-09T09:53:24.594+09:00",
        "isFirst": true,
        "locationConsent": false
    }
     */
    
    let id: Int
    let email: String
    let nickname: String
    let profileImage: String?
    let createdDate: String
    let isFirst: Bool
    let locationConsent: Bool
}
