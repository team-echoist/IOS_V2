//
//  File.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import UIKit
import DeviceKit
import WebKit

// MARK: Device

/// 아이폰(시뮬레이터 포함)
func isPhone() -> Bool {
    return Device.current.isPhone
}

/// 아이패드(시뮬레이터 포함)
func isPad() -> Bool {
    return Device.current.isPad
}

/// 시뮬레이터
func isSimulator() -> Bool {
    return Device.current.isSimulator
}
