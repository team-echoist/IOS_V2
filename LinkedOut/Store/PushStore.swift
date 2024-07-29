//
//  PushStore.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/04.
//  Copyright © 2020 Foodinko. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import RxSwift
import DeviceKit

extension DefaultsKeys {
    var deviceToken: DefaultsKey<String?> { return .init("deviceToken") }
    var serverSent: DefaultsKey<Bool?> { return .init("serverSent") }
    var deviceId: DefaultsKey<String?> { return .init("deviceId") }
}

public protocol PushStoreType {
    /**
     * 권한 등록
     */
    static func setupAPN(_ application: UIApplication)
    
    /**
     * 토큰 수신
     */
    static func receivedDeviceToken(_ deviceToken: Data)
    
    /**
     * 메시지 수신
     */
    static func receivedPushMessage(_ userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    
    /**
    * 뱃지 카운트 설정
    */
    static func setIconBadgeNumber(_ count: Int)
    
    /**
    * 디바이스 토큰 set
    */
    static func setDeviceToken(_ token: String?)
    
    /**
    * 디바이스 토큰 get
    */
    static func getDeviceToken() -> String
    
    /**
    * 디바이스 토큰 has
    */
    static func hasDeviceToken() -> Bool
    
    /**
    * 디바이스 토큰 서버 전송 여부
    */
    static func isServerSent() -> Bool
    
    /**
     * Build Type(D, P)
     */
    static func getBuildType() -> String
    
    /**
     * 디바이스 아이디 set
     */
    static func setDeviceId(_ dvcId: String?)
    
    /**
    * 디바이스 아이디 get
    */
    static func getDeviceId() -> String
    
    /**
    * 디바이스 아이디 has
    */
    static func hasDeviceId() -> Bool
}

public class PushStore: PushStoreType {
    
    public static let isReceivedDeviceToken = PublishSubject<Bool>()//(value: false)
    
    public init() {
        
    }
    
    public class func setupAPN(_ application: UIApplication) {
        if #available(iOS 10, *) {
            UNUserNotificationCenter
                .current()
                .requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    guard error == nil else { log.debug("error"); return }
                    if granted {
                        log.debug("registered remote notifications")
                        DispatchQueue.main.async { application.registerForRemoteNotifications() }
                    } else {
                        log.debug("handle user denying permissions")
                    }
            }
            
            DispatchQueue.main.async { application.registerForRemoteNotifications() }
        } else {
            DispatchQueue.main.async {
                let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
            }
        }
    }
    
    public class func receivedDeviceToken(_ deviceToken: Data) {
        let hexString = deviceToken.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
        log.debug(hexString)
        PushStore.setDeviceToken(hexString)
        PushStore.isReceivedDeviceToken.onNext(true)
    }
    
    public class func receivedPushMessage(_ userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           // TODO: received push mesage 1
           
           /*
           // 푸시 메시지 저장
           [[CommonData shared] addPushMessage:userInfo];

           // 앱이 백그라운드상태였거나, 프로세스가 실행될때
           if([application applicationState] == UIApplicationStateInactive) {
               NSLog(@"UIApplicationStateInactive.");
               //앱이 실행되어 메인화면 뷰가 만들어진 상태
               if([[CommonData shared] getAppLaunched]) {
                   //[Utils postNotification:kNotificationDidReceivedPush andObject:nil];
                   [self receivedPushMessage];
               }
               else {
                   //[Utils postNotification:kNotificationDidReceivedPush andObject:nil];
                   [self receivedPushMessage];
               }
           }
           // 액티브 상태
           else if([application applicationState] == UIApplicationStateActive) {
               NSLog(@"UIApplicationStateActive.");
               //[Utils postNotification:kNotificationDidReceivedPush andObject:nil];
               [self receivedPushMessage];
           }
           else if([application applicationState] == UIApplicationStateBackground) {
               NSLog(@"UIApplicationStateBackground.");
           }
    */
       }
    
    public class func setIconBadgeNumber(_ count: Int) {
        UIApplication.shared.applicationIconBadgeNumber = count
    }
    
    public class func setDeviceToken(_ token: String?) {
        if hasDeviceToken() {
            // 저장된 토큰과 동일하면 저장하지 않음
            if getDeviceToken() == token { return }
            
            // token을 새로 발급받았을 경우 or 아직 userDefaults에 저장되지 않은 경우
            Defaults.serverSent = false
        }
        log.debug("saved token: \(String(describing: token))")
        Defaults.deviceToken = token
    }
    
    public class func getDeviceToken() -> String {
        guard isSimulator() else { return "123456789" }
        guard let token = Defaults.deviceToken else { return "" }
        log.debug("\(String(describing: token))")
        return token
    }
    
    public class func hasDeviceToken() -> Bool {
        guard isSimulator() else { return true }
        log.debug("\(String(describing: Defaults.hasKey(\.deviceToken)))")
        return Defaults.hasKey(\.deviceToken)
    }
    
    public class func isServerSent() -> Bool {
        guard let sent = Defaults.serverSent else { return false }
        log.debug("\(String(describing: sent))")
        return sent
    }
    
    public class func getBuildType() -> String {
        var type = "P"
        #if DEBUG
        type = "D"
        #endif
        log.debug("\(String(describing: type))")
        return type
    }
    
    public class func setDeviceId(_ dvcId: String?) {
        Defaults.serverSent = dvcId != nil ? true : false
        Defaults.deviceId = dvcId
        
        log.debug("saved deviceId: \(String(describing: dvcId))")
        log.debug("server sent: \(String(describing: Defaults.serverSent))")
    }
    
    public class func getDeviceId() -> String {
        guard let dvcId = Defaults.deviceId else { return "" }
        log.debug("\(String(describing: dvcId))")
        return dvcId
    }
    
    public class func hasDeviceId() -> Bool {
        log.debug("\(String(describing: Defaults.hasKey(\.deviceId)))")
        return Defaults.hasKey(\.deviceId)
    }

}// class
