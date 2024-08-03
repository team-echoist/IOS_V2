//
//  String+Date.swift
//  LinkedOut
//
//  Created by 이상하 on 8/2/24.
//

import Foundation

extension String {
    
    func changeDateStringFormat(dateFormat: String = "yyyy-MM-dd HH:mm:ss", changeForamt: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let date = self
        let formatter  = DateFormatter()
        formatter.dateFormat = dateFormat

        let convertDate = formatter.date(from: date)

        let changeFormat = DateFormatter()
        changeFormat.dateFormat = changeForamt
        if let date = convertDate { // Date 타입으로 변환
            return changeFormat.string(from: date)
        }
        else {
            return changeForamt
        }
    }
}
