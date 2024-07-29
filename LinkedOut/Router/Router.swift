//
//  Router.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/19.
//  Copyright © 2020 정윤호. All rights reserved.
//


import Foundation
import ReactorKit
import RxCocoa
import RxSwift
import RxOptional
import SnapKit
import SafariServices


public final class Router: BaseViewController, View {

    public typealias Reactor = RouterReactor
    
    // MARK:  Log
    lazy private(set) var logTag: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: Rx
    
    // MARK: Constant
    fileprivate struct Color { }
    fileprivate struct Constant { }
    fileprivate struct Font { }
    fileprivate struct Image { }
    fileprivate struct Metric { }
    
    
    // MARK: Property
    public var dependencies: DependenciesType
    public var viewFactory: DependenciesViewControllerType
    public var repoFactory: DependenciesRepositoryType
    
    var rootViewController: UIViewController? = nil;
    
    
    // MARK: UI
    public var current: UIViewController
    
    // MARK: Initialize
    public init(
        reactor: Reactor,
        dependencies: DependenciesType,
        viewFactory: DependenciesViewControllerType,
        repoFactory: DependenciesRepositoryType
    ) {
        defer { 
            self.reactor = reactor
        }
        
        self.dependencies = dependencies
        self.viewFactory = viewFactory
        self.repoFactory = repoFactory
                
        if (self.rootViewController == nil) {
            let mainVc = UINavigationController(rootViewController: self.viewFactory.makeMainTabBar())
            mainVc.interactivePopGestureRecognizer?.isEnabled = false
            mainVc.navigationBar.isHidden = true
            self.rootViewController = mainVc
            self.current = mainVc
        } else {
            self.current = self.rootViewController!
        }
        
        
        ///Router -> self.current(added view controller) = UINavigationViewController(RootViewController)

        log.debug("make current view controller: \(self.current)")
        super.init()
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.add(self.current)
        log.debug("add current view controller - parent: \(self.current.parent), superView: \(self.current.view.superview)")
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        // https://stackoverflow.com/questions/19022210/preferredstatusbarstyle-isnt-called
        return Router.statusBarStyle
    }

    static var statusBarStyle: UIStatusBarStyle = .darkContent
    
    // MARK: Layout
    override public func layoutCommon() {
        super.layoutCommon()
        
    }
    
    public override func layoutPhone() {
        super.layoutPhone()
        
    }
    
    public override func layoutPad() {
        super.layoutPad()
        
    }
    
    
    // MARK: Configure
    
    public func bind(reactor: Reactor) {
        /**
         * State
         */
        // Loading        
        reactor.state
            .map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe({ [weak self] (event) in
                if let isLoading = event.element {
                    if isLoading {
                        self?.startAnimating()
                    } else {
                        self?.stopAnimating()
                    }
                }
            })
            .disposed(by: self.disposeBag)
        
        // Error
        reactor.state
            .map { $0.error }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] (error) in
                log.debug("Error - Title:\(error.title ?? "non title")), Code: \(error.code)), Description: \(error.description))")
                self?.showAlert(message: error.description)
            })
            .disposed(by: self.disposeBag)
        
        // Alert
        reactor.state
            .map { $0.alert }.filterNil()
            .mapChangedTracked({ $0 })
            .subscribe(onNext: { [weak self] message in
                if let message = message {
                    self?.showAlert(message: message.localized)
                }
                else {
                    self?.showAlert(message: "")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getRoot() -> UINavigationController {
        let childrenFirst = self.children.first as! UINavigationController
//        log.debug("childrenFirst: \(childrenFirst)")
        return childrenFirst
    }
    
    private func screenPopToRoot() {
        self.getRoot().popToRootViewController(animated: false)
    }
    
    private func screenPush(to newScreen: UIViewController, animated: Bool = true) {
        let root = self.getRoot()
        root.pushViewController(newScreen, animated: animated)
    }
    
    private func screenPresent(
        to newScreen: UIViewController,
        animated: Bool = true,
        navigationBarHidden: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        completion: (() -> Void)? = nil) {
            
        let nav = UINavigationController(rootViewController: newScreen)
        nav.modalPresentationStyle = modalPresentationStyle
        nav.navigationBar.isHidden = navigationBarHidden
        let topView = Router.topViewController()
        topView?.present(nav, animated: animated, completion: completion)
    }
    
    private func screenSwitch(
        to newScreen: UIViewController,
        animate: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        if !animate {
            // 1. add new screen
            self.add(newScreen)
        
            // 2. remove previous screen
            self.remove(self.current)
            
            // 3. set current screen
            self.current = newScreen
        } else {
            // current
            self.current.willMove(toParent: nil)
             
            // newScreen
            self.addChild(newScreen)
            newScreen.view.frame = self.view.bounds
            
            
            transition(from: self.current,
                        to: newScreen,
                        duration: 0.3,
                        options: [.transitionCrossDissolve, .curveEaseOut],
                        animations: { // animate
            }) { [weak self] completed in
                // current
                self?.current.view.removeFromSuperview()
                self?.current.removeFromParent()
                 
                // newScreen
                self?.view.addSubview(newScreen.view)
                newScreen.didMove(toParent: self)
                self?.current = newScreen
                 
                completion?()
            }//completed
        }//else
    }
    
    
    // MARK:  Helper
    /// ref: https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
    class func getKeyWindow() -> UIWindow? {
        var keyWindow: UIWindow?
        
        if #available(iOS 13, *) {
            keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        } else {
            keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        }
        
        return keyWindow
    }
    
    class func topViewController() -> UIViewController? {
        if let keyWindow = Router.getKeyWindow() {
            if var viewController = keyWindow.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                print("topViewController -> \(viewController))")
                return viewController
            }
        }
        return nil
    }
    
}

extension Router: RouterType {
    
    public func routeHomeView() {
        let vc = self.viewFactory.makeMain()
        self.screenPush(to: vc)
    }
    
    public func routeMainTabBar() {
        let vc = self.viewFactory.makeMainTabBar()
        self.screenPush(to: vc)
    }
    
    public func getHomeView() -> UIViewController {
        return self.viewFactory.makeMain()
    }
    
    public func getWriting() -> UIViewController {
        return self.viewFactory.makeWriting()
    }
    
    
    public func routeWriting() {
        let vc = self.viewFactory.makeWriting()
        self.screenPush(to: vc)
    }
    
    public func routeComunity() {
        
    }
    
    public func routeProfile() {
        
    }
    
//    public func routeSwitchMainTabBar() {
//        let vc = self.viewFactory.makeTabBar()
//        let nvc = UINavigationController(rootViewController: vc)
//        nvc.interactivePopGestureRecognizer?.isEnabled = false
//        nvc.navigationBar.isHidden = true
//        self.screenSwitch(to: nvc)
//    }
//    
//    public func routeStaffSupportAuthCode(eventSeq: Int?, isEvent: Bool, preScreenId: String) {
//        let vc = StaffSupportAuthCodeViewController(eventSeq: eventSeq, isEvent: isEvent, preScreenId: preScreenId)
//        self.screenPush(to: vc, animated: false)
//    }
    
    public func routeMainView() {
        
    }
}
