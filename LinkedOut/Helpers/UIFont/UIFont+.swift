//
//  UIFont+.swift
//  LinkedOut
//
//  Created by 이상하 on 8/9/24.
//

import UIKit

enum FontName: String {
    case pretendard = "Pretendard"
}
enum FontWeight: String {
    case extraBold = "ExtraBold"
    case bold = "Bold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    case light = "Light"
    case thin = "Thin"
}

struct Font {
    
    
}

extension UIFont {
    
    static func getFont(size: CGFloat, _ fontWeight: FontWeight, _ fontName: FontName = .pretendard) -> UIFont {
        
        let fontName = fontName.rawValue + "-" + fontWeight.rawValue
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
