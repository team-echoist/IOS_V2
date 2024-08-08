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
        static let tabSpace = 8.f
        
        static let navHeight = 36.f
        static let navSideMargin = 20.f
        static let navTitleRightMargin = 10.f
        
        static let tabTopMargin = 16.f
        static let tabHeight = 28.f
        static let tabDividerBottomMargin = -1.f
        static let tabDividerHeight = 2.f
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
        static let divider: UIColor = .init(hexCode: "#AEAEAE")
        static let randomTitle: UIColor = .init(hexCode: "#616FED")
        static let randomSubTitle: UIColor = .init(hexCode: "#696969")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title: UIFont = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    // MARK: - UI
    
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.font = Font.title
        $0.textColor = .Theme.titleBlack
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
    
    private let viTabStack = UIStackView().then {
        $0.spacing = Metric.tabSpace
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private let viRandomTab = ComunityTabView(tabData: .random)
    
    private let viBookmarkedTab = ComunityTabView(tabData: .bookmarked)
    
    private let viTabDivider = UIView().then {
        $0.backgroundColor = Color.divider
    }
    
    // 랜덤 에세이
    private var viEssayRandom: EssayRandomListView
    
    // 팔로잉 에세이
    private let viEssayFollowing = UIView().then {
        $0.backgroundColor = .Theme.black
    }
    
    private let cvEssayFollowing = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.bounces = false
//        $0.register(EssayRandomViewCell.self, forCellWithReuseIdentifier: Constant.essayRandomCell)
    }
        
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer {
            self.reactor = reactor
        }
        let imageOptions: ImageOptions = []
        
        self.viEssayRandom = EssayRandomListView(reactor: reactor, randomCellDependency: EssayRandomViewCell.Dependency(imageOptions: imageOptions))
        super.init()
        self.view.backgroundColor = Color.background
        
        _ = [self.lbTitle, self.viNavStack].map {
            self.viNavigation.addSubview($0)
        }
        
        _ = [self.btnSearch, self.btnBookmark].map {
            self.viNavStack.addArrangedSubview($0)
        }
        
        _ = [self.viTabDivider, self.viTabStack, self.viEssayFollowing, self.viEssayRandom].map {
            self.view.addSubview($0)
        }
        
        _ = [self.viRandomTab, self.viBookmarkedTab].map {
            self.viTabStack.addArrangedSubview($0)
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
            $0.leading.equalToSuperview().inset(Metric.navSideMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.viNavStack.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Metric.navSideMargin)
            $0.leading.equalTo(self.lbTitle.snp.trailing).offset(Metric.navTitleRightMargin)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(Metric.navHeight)
        }
        
        self.viTabStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.navSideMargin)
            $0.trailing.lessThanOrEqualToSuperview().inset(Metric.navSideMargin)
            $0.top.equalTo(self.viNavigation.snp.bottom).offset(Metric.tabTopMargin)
            $0.height.equalTo(Metric.tabHeight)
        }
        
        self.viTabDivider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.viTabStack.snp.bottom).offset(Metric.tabDividerBottomMargin)
            $0.height.equalTo(Metric.tabDividerHeight)
        }
        
        self.viEssayRandom.snp.makeConstraints {
            $0.top.equalTo(self.viTabDivider.snp.bottom).offset(10.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindState(reactor)
        self.bindAction(reactor)
        
        reactor.action.onNext(.inputRefresh)
    }
        
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        
        reactor.state
            .map { $0.selectedTab }
            .subscribe(onNext: { [weak self] selectedTab in
                guard let self = self else { return }
                
                switch selectedTab {
                case .random:
                    self.viRandomTab.setSelected()
                    self.viBookmarkedTab.setDeselected()
                case .bookmarked:
                    self.viRandomTab.setDeselected()
                    self.viBookmarkedTab.setSelected()
                }
            })
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isLoading }
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
    func bindAction(_ reactor: Reactor) {
                
        self.viRandomTab.rx.tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputSelectedTab(.random))
            })
            .disposed(by: self.disposeBag)
        
        self.viBookmarkedTab.rx.tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputSelectedTab(.bookmarked))
            })
            .disposed(by: self.disposeBag)
    }
}

