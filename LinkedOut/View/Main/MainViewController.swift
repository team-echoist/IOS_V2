//
//  TemplateViewController.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/07.
//  Copyright © 2020 정윤호. All rights reserved.
//


import ReactorKit
import RxDataSources
import RxCocoa
import RxSwift
import RxOptional
import RxViewController
import SnapKit
import Device
import ManualLayout

public protocol MainViewControllerType {
    
}

public final class MainViewController: BaseViewController, MainViewControllerType, View {
    
    public typealias Reactor = MainReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
    }
    
    // MARK: Image
    
    public struct Image {
        static let backgroundImage = UIImage(named: "main_background")
        
        static let homeTab = UIImage(named: "home_tab")
        static let writingTab = UIImage(named: "writing_tab")
        static let comunityTab = UIImage(named: "comunity_tab")
        static let myTab = UIImage(named: "my_tab")
    }
    
    // MARK: UI
    
    public let ivBackground = UIImageView().then {
        $0.image = Image.backgroundImage
        $0.layer.masksToBounds = true
    }
    
    public let btnRoute = UIButton().then {
        $0.setTitle("화면 전환", for: .normal)
    }
    
    public let tabbar = UITabBar()
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        
        self.view.addSubview(self.ivBackground)
     
        
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tabbarList = [
        UITabBarItem(title: "홈", image: Image.homeTab, tag: 0),
        UITabBarItem(title: "내 글 목록", image: Image.writingTab, tag: 1),
        UITabBarItem(title: "커뮤니티", image: Image.comunityTab, tag: 2),
        UITabBarItem(title: "마이페이지", image: Image.myTab, tag: 3),
    ]
    
    // MARK: View Life Cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
            
        
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Layout
    
    public override func layoutCommon() {
        super.layoutCommon()
    
        
        self.ivBackground.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {        
        
//        self.bindView(reactor)
//        self.bindState(reactor)
    }
    
    // MARK: Bind - View
    
    public func bindView(_ reactor: Reactor) {
       
    }
    
    public func bindTabbar(_ reactor: Reactor) {
      
    }
    
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        self.bindSelectedTab(reactor)
    }
    
    public func bindSelectedTab(_ reactor: Reactor) {
        reactor.state
            .map { $0.selectedTab }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedTab in
                guard let self = self else { return }
                   switch selectedTab {
                   case .home:
                       self.displayContentController(SceneDelegate.shared.router.getHomeView())
                   case .comunity:
                       self.displayContentController(SceneDelegate.shared.router.getHomeView())
                   case .profile:
                       self.displayContentController(SceneDelegate.shared.router.getHomeView())
                   case .writing:
                       self.displayContentController(SceneDelegate.shared.router.getWriting())
                   }
                
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event
    
    private func displayContentController(_ content: UIViewController) {
        let _ = children.map { child in
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        // Add new child view controller
        addChild(content)
        view.addSubview(content.view)
        content.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        content.didMove(toParent: self)
    }


    // MARK: Action
}
