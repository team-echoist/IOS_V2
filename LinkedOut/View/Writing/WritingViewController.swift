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

public protocol WritingViewControllerType {
    
}

public final class WritingViewController: BaseViewController, WritingViewControllerType, View {
    
    public typealias Reactor = WritingReactor
    
    // MARK: Constant
    
    fileprivate struct Metric {
        static let nicknameLeftMargin = 20.f
        static let rightNavSpace = 8.f
        static let navRightMargin = 20.f
        static let btnSize = 30.f
    }
        
    fileprivate struct Constant {
    }
    
    fileprivate struct Image {
        static let search = UIImage(named: "search")
        static let alarm = UIImage(named: "alarm")
    }
    
    // MARK: UI
    
    private let lbNickname = UILabel().then {
        $0.text = "님"
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 24.0)
    }
    
    private let viNavStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = Metric.rightNavSpace
    }
    
    private let btnAlarm = UIButton().then {
        $0.setImage(Image.alarm, for: .normal)
    }
    private let btnSearch = UIButton().then {
        $0.setImage(Image.search, for: .normal)
    }
    
    private let assayCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.bounces = false
//        $0.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
    }
    
    // MARK: Property
    
//    fileprivate let dataSource: DataSource
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        
        let _ = [self.lbNickname, self.viNavStack].map {
            self.viNavigation.addSubview($0)
        }
        
        let _ = [self.btnSearch, self.btnAlarm].map {
            self.viNavStack.addArrangedSubview($0)
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
        
        self.lbNickname.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.nicknameLeftMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.viNavStack.snp.makeConstraints {
            $0.height.equalTo(Metric.btnSize)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Metric.navRightMargin)
        }
        
        let _ = [self.btnAlarm, self.btnSearch].map {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(Metric.btnSize)
            }
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        reactor.action.onNext(.refresh)
            
    }
    
    // MARK: Event


    // MARK: Action
}
