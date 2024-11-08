//
//  LoginResult.swift
//  LinkedOut
//
//  Created by 이상하 on 10/23/24.
//

import Foundation

public struct LoginResult: Codable {
    
    let accessToken: String
    let refreshToken: String
}
