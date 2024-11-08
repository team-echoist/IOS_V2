//
//  TemplateModel.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/09.
//  Copyright © 2020 정윤호. All rights reserved.
//

import Foundation

public struct SignupTermsModel {
    
    public enum TermsType {
        case service
        case privacy
        case age
        case location
        case marketing
        case alarm
    }
    
    public struct TermsData {
        let type: TermsType
        let content: String
        let required: Bool
        var link: String? = nil
        var selected: Bool = false
    }
            

    public static func geratedTermsData() -> [TermsData] {
        return [
            TermsData(type: .service, content: "서비스 이용약관 동의", required: true, link: "https://www.naver.com"),
            TermsData(type: .privacy, content: "개인정보 수집 및 이용 동의", required: true),
            TermsData(type: .age, content: "만 14세 이상입니다", required: true),
            TermsData(type: .location, content: "위치 기반 서비스 이용 약관 동의", required: false),
            TermsData(type: .marketing, content: "마케팅 정보 수신 동의", required: false),
            TermsData(type: .alarm, content: "서비스 알림 수신 동의", required: false),
        ]
    }
}
