//
//  String+.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import UIKit

extension String {
    
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
            " ", options:.regularExpression, range: nil)
    }
    
    
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                return nil
            }
        }
    
    var toBool: Bool {
        return self.lowercased() == "y"
    }
    
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
    
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        guard to < count else {
            return self
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        return String(self[startIndex ..< endIndex])
    }
    
    func htmlToAttributedString(font: UIFont) -> NSAttributedString? {
      //let testhtml = "<h1><br></h1><h1>안녕하세요</h1><div><u>푸딘코입니다.</u></div><div style=\"margin-left: 25px;\"><del>임시 테스트&nbsp;</del></div><div><strong>사용에 불편을 드려서 죄송합니다.</strong></div><p style=\"color:blue\">This is demo content.</p><div>감사합니다.</div>"
//        let string = self.replacingOccurrences(of: "<br>", with: "<p></p>")

        let newHTML = String(format:"<span style=\"font-size: \(font.pointSize); font-family: \(font.familyName), \(font.fontName);\">%@</span>", self)
      
        guard let data = newHTML.data(using: .utf8) else {
            return NSAttributedString()
        }
            
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func htmlToString(font: UIFont) -> String {
        return self.htmlToAttributedString(font: font)?.string ?? ""
    }
    
    func underLined(font: UIFont) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue, NSAttributedString.Key.font: font])
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
