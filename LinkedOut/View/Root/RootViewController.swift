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

public protocol RootViewControllerType {
    
}

public final class RootViewController: BaseViewController, RootViewControllerType, View {
    
    public typealias Reactor = RootReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
    }
    
    fileprivate struct Image {
        static let logo = UIImage(named: "splash")
    }
    
    // MARK: Initialize
    private let ivLogo = UIImageView().then {
        $0.image = Image.logo
    }
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        self.addView()
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
    
    func addView() {
        let _ = [self.ivLogo].map {
            self.view.addSubview($0)
        }
    }
    
    public override func layoutCommon() {
        
        self.ivLogo.snp.makeConstraints {
            $0.height.width.equalToSuperview()
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        
        self.bindState(reactor)
        self.checkStatus(reactor)
    }
    
    // MARK: Bind - Status
    
    private func bindState(_ reactor: Reactor) {
        self.bindStateAlert(reactor)
    }
    
    private func bindStateAlert(_ reactor: Reactor) {
        reactor.state
            .map { $0.alert }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] message in
                guard let self = self else { return }
                self.showAlert(message: message.localized)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
    private func checkStatus(_ reactor: Reactor) {
        reactor.action.onNext(.setInit)
    }
}
