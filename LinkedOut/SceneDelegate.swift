//
//  SceneDelegate.swift
//  LinkedOut
//
//  Created by 이상하 on 7/24/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        SceneDelegate.shared.setUpRouter(scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

extension SceneDelegate {
    public static var shared: SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = (scene?.delegate as! SceneDelegate)
        return sd
    }
    
    // Usage: let router = SceneDelegate.shared.router
    public var router: RouterType {
       let router = window!.rootViewController as! RouterType
       return router
   }
    
    public func setUpRouter(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        
        window = UIWindow(windowScene: windowScene)
        
        let dependency = Dependencies()
        
        window?.rootViewController = nil
        
        window?.rootViewController = Router(
            reactor: RouterReactor(),
            dependencies: dependency,
            viewFactory: dependency,
            repoFactory: dependency
        )
        
        window?.makeKeyAndVisible()
    }
}

