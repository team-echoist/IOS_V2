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

public protocol EssayCreateViewControllerType {
    
}

public final class EssayCreateViewController: BaseViewController, EssayCreateViewControllerType, View {
    
    public typealias Reactor = EssayCreateReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
        static let cancel = "취소"
        static let complete = "완료"
        static let titlePlaceholder = "제목을 입력하세요"
        static let contentPlaceholder = "내용을 입력하세요"
    }
    
    // MARK: Metric
        
    fileprivate struct Metric {
        static let navigationMargin = 20.f
        static let tfTitleSideMargin = 6.f
        static let dividerHeight = 1.f
        
        static let contentsTopMargin = 26.f
        static let contentsSideMargin = 20.f
    }
    
    // MARK: Image
    
    fileprivate struct Image {
        
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let cancel = UIFont.getFont(size: 14, .regular)
        static let complete = UIFont.getFont(size: 16, .regular)
        static let title = UIFont.getFont(size: 16, .regular)
        static let contents = UIFont.getFont(size: 16, .regular)
    }
    
    // MARK: Attribute
    
    fileprivate struct Attribute {
        static let titlePlaceholder = NSAttributedString(string: Constant.titlePlaceholder, attributes: [NSAttributedString.Key.foregroundColor: Color.titlePlaceholder])
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let cancel = UIColor(hexCode: "#686868")
        static let complete = UIColor.white
        static let title = UIColor.white
        static let content = UIColor.white
        static let contentPlaceholder = UIColor(hexCode: "#686868")
        static let titlePlaceholder = UIColor(hexCode: "#686868")
        
        static let divider = UIColor(hexCode: "#686868", alpha: 0.3)
    }
    
    // MARK: Ui
    
    private let viTitleNavigation = UIView()
    
    private let btnCancel = UIButton().then {
        $0.setTitle(Constant.cancel, for: .normal)
        $0.setTitleColor(Color.cancel, for: .normal)
        $0.titleLabel?.font = Font.cancel
    }
    
    private let btnComplete = UIButton().then {
        $0.setTitle(Constant.complete, for: .normal)
        $0.setTitleColor(Color.complete, for: .normal)
        $0.titleLabel?.font = Font.complete
    }
    
    private let tfTitle = UITextField().then {
        $0.placeholder = Constant.titlePlaceholder
        $0.attributedPlaceholder = Attribute.titlePlaceholder
        $0.textColor = Color.titlePlaceholder
        $0.font = Font.title
    }
    
    private let viDivider = UIView().then {
        $0.backgroundColor = Color.divider
    }
    
    private let tvContents = UITextView().then {
        $0.font = Font.contents
        $0.backgroundColor = .clear
        $0.textColor = Color.content
    }
    
    // MARK: Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        _ = [self.viTitleNavigation, self.viDivider, self.tvContents].map {
            self.view.addSubview($0)
        }
        
        _ = [self.btnCancel, self.tfTitle, self.btnComplete].map {
            self.viTitleNavigation.addSubview($0)
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
        
        // 상단 네비게이션
        self.viTitleNavigation.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.navigationMargin)
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(UtilsScreen.getSizeNavigationBar())
        }
        
        self.btnCancel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.tfTitle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(self.btnCancel.snp.trailing).offset(Metric.tfTitleSideMargin)
            $0.trailing.lessThanOrEqualTo(self.btnComplete.snp.leading).offset(-Metric.tfTitleSideMargin)
        }
        
        self.btnComplete.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.viDivider.snp.makeConstraints {
            $0.height.equalTo(Metric.dividerHeight)
            $0.top.equalTo(self.viTitleNavigation.snp.bottom)
            $0.leading.trailing.equalTo(self.viTitleNavigation)
        }
        
        // 컨텐츠
        self.tvContents.snp.makeConstraints {
            $0.top.equalTo(self.viDivider.snp.bottom).offset(Metric.contentsTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentsSideMargin)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindAction(reactor)
    }
    
    public func bindAction(_ reactor: Reactor) {
        
        self.btnCancel.rx
            .tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputCancel)
            })
            .disposed(by: self.disposeBag)
        
        self.btnComplete.rx
            .tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputSave)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
}
