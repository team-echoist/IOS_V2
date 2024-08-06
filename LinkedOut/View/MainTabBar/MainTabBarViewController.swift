//
//  MainTabBarViewController.swift
//  LinkedOut
//
//  Created by 이상하 on 7/29/24.
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

public protocol MainTabBarViewControllerType {
    
}

public final class MainTabBarViewController: BaseViewController, MainTabBarViewControllerType, View {
    
    public typealias Reactor = MainTabBarReactor
    
    
    // MARK: Constant
    
    fileprivate struct Constant {
    }
    
    // MARK: Color
    
    // MARK: Image
    fileprivate struct Image {
        static let homeTab = UIImage(named: "home_tab")
        static let homeTabSelected = UIImage(named: "home_tab_selected")
        static let writingTab = UIImage(named: "writing_tab")
        static let writingTabSelected = UIImage(named: "writing_tab_selected")
        static let comunityTab = UIImage(named: "comunity_tab")
        static let comunityTabSelected = UIImage(named: "comunity_tab_selected")
        static let myTab = UIImage(named: "my_tab")
        static let myTabSelected = UIImage(named: "my_tab_selected")
    }
    
    // MARK: UI
    
    private lazy var tabbar: UITabBar = {
        let tabbar = UITabBar()
        tabbar.items = self.tabbarList
        tabbar.barTintColor = .Theme.black
        tabbar.tintColor = .white
        tabbar.isTranslucent = false
        
        tabbar.selectedItem = self.tabbarList.first
        self.view.addSubview(tabbar);
        
        return tabbar
    }()
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        
        for (index, element) in self.tabbarList.enumerated() {
            element.tag = index
        }
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Variable
    private let tabbarList = [
        UITabBarItem(title: "홈", image: Image.homeTab, selectedImage: Image.homeTabSelected),
        UITabBarItem(title: "내 글 목록", image: Image.writingTab, selectedImage: Image.writingTabSelected),
        UITabBarItem(title: "커뮤니티", image: Image.comunityTab, selectedImage: Image.comunityTabSelected),
        UITabBarItem(title: "마이페이지", image: Image.myTab, selectedImage: Image.myTabSelected),
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
        
        self.tabbar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(54.0)
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindView(reactor)
        self.bindState(reactor)
    }
    
    // MARK: Bind - View
    func bindView(_ reactor: Reactor) {
        self.tabbar.rx.didSelectItem
            .map { item -> MainTabBarReactor.Action in
                print(item)
                switch item.tag {
                case 0:
                    return .selectTab(.home)
                case 1:
                    return .selectTab(.writing)
                case 2:
                    return .selectTab(.comunity)
                case 3:
                    return .selectTab(.profile)
                default:
                    return .selectTab(.home)
                }
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - State
    func bindState(_ reactor: Reactor) {
        reactor.state
            .map { $0.selectedTab }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedTab in
                guard let self = self else { return }
                   switch selectedTab {
                   case .home:
                       self.displayContentController(HomeViewController(reactor: HomeReactor()))
                   case .comunity:
                       self.displayContentController(SceneDelegate.shared.router.getComunity())
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
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(self.tabbar.snp.top)
        }
        content.didMove(toParent: self)
    }


    // MARK: Action
}

