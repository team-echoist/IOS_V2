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

public protocol SignupTermsViewControllerType {
    
}

public final class SignupTermsViewController: BaseViewController, SignupTermsViewControllerType, View {
    
    public typealias Reactor = SignupTermsReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
        static let title = "이용약관"
        static let subTitle = "회원 서비스 이용을 위해 회원가입을 해주세요."
        
        static let allAgree = "전체 동의"
        
        static let btnNext = "확인"
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title = UIFont.getFont(size: 20.f, .semiBold)
        static let subTitle = UIFont.getFont(size: 15.f, .regular)
        
        static let agreeAll = UIFont.getFont(size: 16.f, .regular)
        static let agree = UIFont.getFont(size: 14.f, .regular)
        
        static let btnNext = UIFont.getFont(size: 16, .semiBold)
    }
    
    // MARK: Metric
    
    fileprivate struct Metric {
        static let logoLeftMargin = 110.f
        
        static let titleTopMargin = 42.f
        static let titleSideMargin = 20.f
        static let subTitleTopMargin = 6.f
        
        static let contentTopMargin = 45.f
        static let contentSideMargin = 20.f
        
        static let agreeSpacing = 8.f
        static let agreeSize = 34.f
        
        static let btnNextTopMargin = 36.f
        static let btnNextBottomMargin = 20.f
        static let btnNextHeight = 50.f
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let agreeFont = UIColor(hexCode: "#919191")
        
        static let btnNextDisableBg = UIColor(hexCode: "#868686")
        static let btnNextDisableFg = UIColor(hexCode: "#343434")
        
        static let btnNextEnableBg = UIColor(hexCode: "#616FED")
        static let btnNextEnableFg = UIColor(hexCode: "#000000")
                        
    }
    
    // MARK: Image
    
    fileprivate struct Image {
        static let bgLogo = UIImage(named: "login_back_logo")
        
        static let agreeCheck = UIImage(named: "check_primary_icon")
        static let agreeUncheck = UIImage(named: "uncheck_gray_icon")
        static let allAgreeCheck = UIImage(named: "check_primary_primary_icon")
        static let allAgreeUncheck = UIImage(named: "uncheck_gray_round_icon")
    }
    
    // MARK: View
    
    private let ivLogo = UIImageView().then {
        $0.image = Image.bgLogo
    }
    
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.font = Font.title
        $0.textColor = .white
    }
    
    private let lbSubtitle = UILabel().then {
        $0.text = Constant.subTitle
        $0.font = Font.subTitle
        $0.textColor = .white
    }
    
    private let viContent = UIView()
    
    private let viStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.agreeSpacing
    }
    
    private let btnAllAgree = UIButton().then {
        $0.setTitle(Constant.allAgree, for: .normal)
        $0.setImage(Image.allAgreeUncheck, for: .normal)
        $0.setImage(Image.allAgreeCheck, for: .selected)
        $0.semanticContentAttribute = .forceLeftToRight
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
    
    private var agreeButtons = [TermsAgreeButton]()
    
    private let btnNext = UIButton().then {
        $0.isEnabled = false
        $0.setTitle(Constant.btnNext, for: .normal)
        $0.setTitleColor(Color.btnNextEnableFg, for: .normal)
        $0.setTitleColor(Color.btnNextDisableFg, for: .disabled)
    }
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        _ = [self.ivLogo, self.lbTitle, self.lbSubtitle, self.viContent].map {
            self.view.addSubview($0)
        }
        
        _ = [self.btnAllAgree, self.viStack, self.btnNext].map {
            self.viContent.addSubview($0)
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
        super.layoutNavigationViewItems()
        super.layoutCommon()
        
        self.ivLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.logoLeftMargin)
            $0.top.trailing.equalToSuperview()
        }
        
        self.lbTitle.snp.makeConstraints {
            $0.top.equalTo(self.viNavigation.snp.bottom).offset(Metric.titleTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.titleSideMargin)
        }
        
        self.lbSubtitle.snp.makeConstraints {
            $0.top.equalTo(self.lbTitle.snp.bottom).offset(Metric.subTitleTopMargin)
            $0.leading.trailing.equalTo(self.lbTitle)
        }
        
        self.viContent.snp.makeConstraints {
            $0.top.equalTo(self.lbSubtitle.snp.bottom).offset(Metric.contentTopMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentSideMargin)
            $0.bottom.greaterThanOrEqualToSuperview()
        }
        
        self.btnAllAgree.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.greaterThanOrEqualToSuperview()
            $0.top.equalToSuperview()
        }
        
        self.viStack.snp.makeConstraints {
            $0.top.equalTo(self.btnAllAgree.snp.bottom).offset(Metric.agreeSpacing)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.btnNext.snp.makeConstraints {
            $0.top.equalTo(self.viStack.snp.bottom).offset(Metric.btnNextTopMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.btnNextHeight)
        }
        
        self.generateAgreeButtons()
    }
    
    private func generateAgreeButtons() {
        guard let reactor = self.reactor else { return }

        for (_, termsData) in reactor.currentState.termsDatas.enumerated() {
            let button = TermsAgreeButton(reactor: TermsAgreeButtonReactor(termsData: termsData))
            self.viStack.addArrangedSubview(button)
            
            button.rx.tap.subscribe(onNext: {
                reactor.action.onNext(.inputAgree(termsData.type))
            })
            .disposed(by: self.disposeBag)
            
            self.agreeButtons.append(button)
        }
    }
    
    // MARK: - Bind
    
    public func bind(reactor: Reactor) {
        self.bindState(reactor)
        self.bindAction(reactor)
        self.bindView(reactor)
    }
    
    // MARK: Bind - State
    
    private func bindState(_ reactor: Reactor) {
        reactor.state.map { $0.isAllAgree }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.btnNext.isEnabled = $0
                self.btnNext.backgroundColor = $0 ? Color.btnNextEnableBg : Color.btnNextDisableBg
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - Action
    
    private func bindAction(_ reactor: Reactor) {
        self.btnAllAgree.rx.tap.subscribe(onNext: {
            reactor.action.onNext(.inputAllAgree)
        })
        .disposed(by: self.disposeBag)
        
        self.btnNext.rx.tap.subscribe(onNext: {
            reactor.action.onNext(.inputNext)
        })
        .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - Views
    
    private func bindView(_ reactor: Reactor) {
        reactor.state
            .map { $0.termsDatas }
            .subscribe(onNext: { [weak self] termsDataList in
                guard let self = self, self.agreeButtons.count == termsDataList.count else { return }
                
                for (index, termData) in termsDataList.enumerated() {
                    let agreeButton = self.agreeButtons[index]
                    agreeButton.reactor?.action.onNext(.toggleAgreeButton(termData.selected))
                }
            })
            .disposed(by: disposeBag)
                
    }
    
    // MARK: Event


    // MARK: Action
    
}
