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

public protocol WritingViewControllerType {
    
}

public final class WritingViewController: BaseViewController, WritingViewControllerType, View {
    
    public typealias Reactor = WritingReactor
    public typealias DataSource = RxCollectionViewSectionedReloadDataSource<EssaySection>

    
    // MARK: Constant
    
    fileprivate struct Metric {
        static let nicknameLeftMargin = 20.f
        static let rightNavSpace = 8.f
        static let navRightMargin = 20.f
        static let btnSize = 30.f
        
        static let sectionLineSpacing = 0.f
        static let sectionInsetLeftRight = 0.f
        static let sectionInteritemSpacing = 0.f
    }
        
    fileprivate struct Constant {
        static let essayCell = "EssayCell"
    }
    
    fileprivate struct Image {
        static let search = UIImage(named: "search")
        static let alarm = UIImage(named: "alarm")
    }
    
    fileprivate struct Font {
        static let tab: UIFont = .systemFont(ofSize: 14.0, weight: .regular)
    }
    
    fileprivate struct Color {
        static let divider: UIColor = .init(hexCode: "#686868", alpha: 0.3)
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
        $0.register(EssayViewCell.self, forCellWithReuseIdentifier: Constant.essayCell)
    }
    
    private let viStackTab = UIStackView().then {
        $0.spacing = 8.0
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private let viEssayTab = WritingTabView(tabData: nil)
    
    private let viPostedTab = WritingTabView(tabData: nil)
    
    private let viStoryTab = WritingTabView(tabData: nil)
    
    private let viTabDivider = UIView().then {
        $0.backgroundColor = Color.divider
    }
    
    // MARK: Property
    
    fileprivate let dataSource: DataSource
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor,
        cellDependency: EssayViewCell.Dependency
    ) {
        defer { self.reactor = reactor }
        self.dataSource = type(of: self).dataSourceFactory(cellDependency: cellDependency)
        super.init()
        
        
        let _ = [self.lbNickname, self.viNavStack].map {
            self.viNavigation.addSubview($0)
        }
        
        let _ = [self.btnSearch, self.btnAlarm].map {
            self.viNavStack.addArrangedSubview($0)
        }
        
        let _ = [self.viStackTab, self.viTabDivider, self.assayCollectionView].map {
            self.view.addSubview($0)
        }
        
        let _ = [self.viEssayTab, self.viPostedTab, self.viStoryTab].map {
            self.viStackTab.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.height.equalTo(28.0)
            }
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
        
        self.viStackTab.snp.makeConstraints {
            $0.top.equalTo(self.viNavigation.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.lessThanOrEqualToSuperview().inset(20)
            $0.height.equalTo(28.0)
        }
        
        self.viTabDivider.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.viStackTab.snp.bottom).offset(-1.0)
            $0.height.equalTo(2.0)
        }
        
        self.view.sendSubviewToBack(self.viTabDivider)
        
        self.assayCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.viStackTab.snp.bottom).offset(18)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Data Source Factory
    
    private static func dataSourceFactory(cellDependency: EssayViewCell.Dependency) -> DataSource {
        return .init(
            configureCell: { datasource, collectionview, indexPath, sectionItem in
                switch sectionItem {
                case .essayViewCellReactor(let reactor):
                    let cell = collectionview.dequeueReusableCell(withReuseIdentifier: Constant.essayCell, for: indexPath) as! EssayViewCell
                    
                    cell.dependency = cellDependency
                    cell.reactor = reactor
                    return cell
                }
            }
        )
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        reactor.action.onNext(.refresh)
        self.bindState(reactor)
        self.bindView(reactor)
        self.bindViewAction(reactor)
    }
    
    // MARK: Bind - State
    
    public func bindState(_ reactor: Reactor) {
        
        reactor.state.map { $0.selectedTab }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] selectedTab in
                guard let self = self else { return }
                
                // TODO: Reactor 로 고치기
                switch selectedTab {
                case .essay:
                    DispatchQueue.main.async {
                        self.viEssayTab.setSelected()
                        self.viPostedTab.setDeselected()
                        self.viStoryTab.setDeselected()
                    }
                case .posted:
                    DispatchQueue.main.async {
                        self.viEssayTab.setDeselected()
                        self.viPostedTab.setSelected()
                        self.viStoryTab.setDeselected()
                    }
                case .story:
                    DispatchQueue.main.async {
                        self.viEssayTab.setDeselected()
                        self.viPostedTab.setDeselected()
                        self.viStoryTab.setSelected()
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - View
    public func bindView(_ reactor: Reactor) {
        self.bindTab(reactor)
        self.bindViewCollection(reactor)
    }
    
    public func bindTab(_ reactor: Reactor) {
        reactor.state.map { $0.tabList }
            .subscribe(onNext: { [weak self] list in
                guard let self = self else { return }
                                
                self.viEssayTab.setTabData(tabData: list[0])
                self.viPostedTab.setTabData(tabData: list[1])
                self.viStoryTab.setTabData(tabData: list[2])
            })
            .disposed(by: self.disposeBag)
    }
    
    public func bindViewCollection(_ reactor: Reactor) {
        reactor.state
            .map { $0.essayList }
            .bind(to: self.assayCollectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
        
        self.assayCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
        
    
    // MARK: Event


    // MARK: Action
    
    public func bindViewAction(_ reactor: Reactor) {
        self.bindTabAction(reactor)
    }
    
    public func bindTabAction(_ reactor: Reactor) {
        
        self.viEssayTab.rx.tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputTab(.essay))
            })
            .disposed(by: self.disposeBag)
        
        self.viPostedTab.rx.tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputTab(.posted))
            })
            .disposed(by: self.disposeBag)
        
        self.viStoryTab.rx.tapGesture()
            .filter { $0.state == .ended }
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputTab(.story))
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: Extension - UICollectionViewDelegateFlowLayout

extension WritingViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch self.dataSource[section] {
            case .items:
                let topBottom = Metric.sectionLineSpacing
                let leftRight = Metric.sectionInsetLeftRight
            return UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionItem = self.dataSource[section]
        switch sectionItem {
            case .items:
            return Metric.sectionLineSpacing
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch self.dataSource[section] {
            case .items:
                return Metric.sectionInteritemSpacing
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionItem = self.dataSource[indexPath]
        switch sectionItem {
        case .essayViewCellReactor(let reactor):
            return EssayViewCell.size(width: self.view.width, reactor: reactor)
        }
    }
    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.width, height: Metric.sectionHeaderHeight /*collectionView.width * Metric.sectionHeaderRatio*/)
//    }

//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.width, height: Metric.sectionFooterHeight)
//    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.isDetectEdgesBottom() {
//            self.loadNextPage()
//        }
    }
    
}
