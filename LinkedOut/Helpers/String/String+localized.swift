//
//  String+localized.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
