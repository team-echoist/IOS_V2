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

public protocol SideNavigationViewControllerType {
    
}

public final class SideNavigationViewController: BaseViewController, SideNavigationViewControllerType, View {
    
    public typealias Reactor = SideNavigationReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
    }
    
    // MARK: Component
    private let viContent = UIView().then {
        $0.backgroundColor = .Theme.black
    }
    
    // MARK: Initialize
    
    private var sideNavigationDelegate: ISideNavigationDelegate? = nil;
    
    init(
        reactor: Reactor,
        sideNavigationDelegate: ISideNavigationDelegate
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        self.sideNavigationDelegate = sideNavigationDelegate
        
        _ = [self.viContent].map {
            self.view.addSubview($0)
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
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
                
        self.viContent.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(self.view.frame.width * 0.8)
        }
        
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindPanGesture()
    }
    
    // MARK: Bind - View
    func bindPanGesture() {
        self.bindPanGestureEnd()
        self.bindPanGestureChanged()
    }
    
    // MARK: Bind - State
    
    // MARK: Event


    // MARK: Action
    
    // MARK: Gesture
    func bindPanGestureChanged() {
        self.view.rx.panGesture()
            .when(.changed)
            .subscribe(onNext: { [weak self] gesture in
                guard let self = self else { return }
                let translation = gesture.translation(in: view).x
                
                if translation > 60 {
                    self.view.frame.origin.x = min(0, -view.frame.width + translation)
                } else {
                    self.view.frame.origin.x = max(-view.frame.width, translation)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindPanGestureEnd() {
        self.view.rx.panGesture()
            .when(.ended)
            .subscribe(onNext: { [weak self] gesture in
                guard let self = self else { return }
                let translation = gesture.translation(in: view).x
                let velocity = gesture.velocity(in: view).x
                
                if velocity > 500 {
                    self.sideNavigationDelegate?.openSideNavigationView()
                } else if velocity < -500 {
                    self.sideNavigationDelegate?.hideSideNavigationView()
                } else if translation > view.frame.width * 0.4 {
                    self.sideNavigationDelegate?.openSideNavigationView()
                } else {
                    self.sideNavigationDelegate?.hideSideNavigationView()
                }
            })
            .disposed(by: self.disposeBag)
    }
}
