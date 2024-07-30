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
import RxGesture

public protocol HomeViewControllerType {
    
}

public final class HomeViewController: BaseViewController, HomeViewControllerType, View {
    
    public typealias Reactor = HomeReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
    }
    
    fileprivate struct Metric {
        static let sectionLineSpacing = 0.f
        static let alarmSize = 30.f
        static let menuSize = 24.f
        
        static let menuLeftMargin = 24.f
        static let alarmRightMargin = 24.f
    }
    
    // MARK: Image
    
    public struct Image {
        static let backgroundImage = UIImage(named: "main_background")
        
        static let menu = UIImage(named: "menu")
        static let alarm = UIImage(named: "alarm")
        static let alarmNew = UIImage(named: "alarm_new")
    }
    
    // MARK: UI
    
    public let ivBackground = UIImageView().then {
        $0.image = Image.backgroundImage
        $0.layer.masksToBounds = true
    }
    
    public let btnMenu = UIButton().then {
        $0.setImage(Image.menu, for: .normal)
    }
    
    public let btnAlarm = UIButton().then {
        $0.setImage(Image.alarm, for: .normal)
    }
    
    private lazy var viSideNavigation: SideNavigationViewController = {
        let vi = SideNavigationViewController(reactor: SideNavigationReactor(), sideNavigationDelegate: self)
        self.addChild(vi)

        return vi
    }()
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        
        let _ = [self.ivBackground].map {
            self.view.addSubview($0)
        }
        self.view.sendSubviewToBack(self.ivBackground)
        
        let _ = [self.btnMenu, self.btnAlarm].map {
            self.viNavigation.addSubview($0)
        }
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
        
        // 배경
        self.ivBackground.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        // 상단 버튼
        self.btnAlarm.snp.makeConstraints {
            $0.width.height.equalTo(Metric.alarmSize)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Metric.alarmRightMargin)
        }
        
        self.btnMenu.snp.makeConstraints {
            $0.width.height.equalTo(Metric.menuSize)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Metric.menuLeftMargin)
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {        
        
        self.bindView(reactor)
        self.bindState(reactor)
    }
    
    // MARK: Bind - View
    
    public func bindView(_ reactor: Reactor) {
        
        self.btnAlarm.rx
            .tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputAlarm)
            })
            .disposed(by: self.disposeBag)
        
        self.btnMenu.rx
            .tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputMenu(!reactor.currentState.showMenu))
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        
        reactor.state
            .map { $0.showMenu }
            .distinctUntilChanged()
            .bind(onNext: { [weak self] showMenu in
                guard let self = self else { return }
                if showMenu {
                    self.showSideNavigation()
                } else {
                    self.hideSideNavigation()
                    
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event

    // MARK: Action
    func showSideNavigation() {
        if !self.view.subviews.contains(self.viSideNavigation.view) {
            self.view.addSubview(self.viSideNavigation.view)
            self.viSideNavigation.didMove(toParent: self)
            
            UIView.animate(withDuration: 0.3) {
                self.viSideNavigation.view.frame.origin.x = 0
            }
        }
    }
                
    func hideSideNavigation() {
        if self.view.subviews.contains(self.viSideNavigation.view) {
            self.viSideNavigation.view.removeFromSuperview()
            
            UIView.animate(withDuration: 0.3) {
                self.viSideNavigation.view.frame.origin.x = -self.view.frame.width
            }
        }
    }
}

extension HomeViewController: ISideNavigationDelegate {
    func openSideNavigationView() {
        self.reactor?.action.onNext(.inputMenu(true))
    }
    
    func hideSideNavigationView() {
        self.reactor?.action.onNext(.inputMenu(false))
    }
}
