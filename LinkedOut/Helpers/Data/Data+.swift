//
//  Data+.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import Foundation
import CommonCrypto

extension Data {
    public func sha256() -> String {
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    //sha-256을 호출, 리턴을 byte[]로 받기 때문에, String 변환이 필요
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02X", UInt8(byte))
        }
        
        return hexString
    }
}
