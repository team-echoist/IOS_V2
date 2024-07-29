//
//  FileStore.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/05.
//  Copyright © 2020 Foodinko. All rights reserved.
//

import Foundation

public protocol FileStoreType {
    /**
     * Codable Custom 객체를 UserDefaults에 저장
     */
    func saveToDefaults<T: Codable>(target: T, targetKey: String)
    
    /**
     * Codable Custom 객체를 UserDefaults에서 가져오기
     */
    func loadFromDefaults<T: Codable>(targetType: T.Type, targetKey: String) -> T?
    
    /**
     * Codable Custom 객체를 UserDefaults에서 삭제
     */
    func removeDefaults(targetKey: String)
}

public class FileStore: FileStoreType {
    
    public init() {
        
    }

    public func saveToDefaults<T: Codable>(target: T, targetKey: String) {
        do {
            let encodedTarget = try PropertyListEncoder().encode(target)
            UserDefaults.standard.set(encodedTarget, forKey: targetKey)
        } catch {
            log.debug(error)
        }
        log.debug("--------------------FileStore Begin--------------------")
        log.debug("saved target: \(target)")
        log.debug("--------------------FileStore End--------------------")
    }

    public func loadFromDefaults<T: Codable>(targetType: T.Type, targetKey: String) -> T? {
        var target: T?
        
        do {
            guard let encodedTarget = UserDefaults.standard.object(forKey: targetKey) as? Data else {
                return nil
            }
            target = try PropertyListDecoder().decode(targetType, from: encodedTarget)
            log.debug("--------------------FileStore Begin--------------------")
            log.debug("loaded target: \(String(describing: target))")
            log.debug("--------------------FileStore End--------------------")
        } catch {
            log.debug(error)
        }
        
        return target
    }
    
    public func removeDefaults(targetKey: String) {
        UserDefaults.standard.removeObject(forKey: targetKey)
    }
    
}// class
