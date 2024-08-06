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

public protocol ComunityViewControllerType {
    
}

public final class ComunityViewController: BaseViewController, ComunityViewControllerType, View {
    
    public typealias Reactor = ComunityReactor
    
    // MARK: - Constant
        
    fileprivate struct Constant {
        static let title = "커뮤니티"
    }
    
    // MARK: Metric
        
    fileprivate struct Metric {
        static let rightNavSpace = 8.f
    }
    
    // MARK: Image
        
    fileprivate struct Image {
        static let search = UIImage(named: "search_black")
        static let bookmarkOn = UIImage(named: "bookmark_on")
        static let bookmarkOff = UIImage(named: "bookmark_on")
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let background: UIColor = .init(hexCode: "#D9D9D9")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title: UIFont = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    // MARK: - UI
    
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.font = Font.title
    }
    
    private let btnSearch = UIButton().then {
        $0.setImage(Image.search, for: .normal)
    }
    
    private let btnBookmark = UIButton().then {
        $0.setImage(Image.bookmarkOn, for: .normal)
    }
    
    private let viNavStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metric.rightNavSpace
    }
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        self.view.backgroundColor = Color.background
        
        _ = [self.lbTitle, self.viNavStack].map {
            self.viNavigation.addSubview($0)
        }
        
        _ = [self.btnSearch, self.btnBookmark].map {
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
        
        self.lbTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.centerY.equalToSuperview()
        }
        
        self.viNavStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.leading.equalTo(self.lbTitle.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(36.0)
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {

    }
    
    // MARK: Event


    // MARK: Action
}

