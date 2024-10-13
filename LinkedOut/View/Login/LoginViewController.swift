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

public protocol LoginViewControllerType {
    
}

public final class LoginViewController: BaseViewController, LoginViewControllerType, View {
    
    public typealias Reactor = LoginReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
        
        static let title = "안녕하세요!\n링크드아웃에 오신것을 환영합니다."
        static let idHint = "이메일 주소 또는 아이디"
        static let passwordHint = "비밀번호"
        static let autoLogin = "자동로그인"
        static let login = "로그인"
        
        static let findId = "아이디 찾기"
        static let resetPassword = "비밀번호 재설정"
        static let register = "회원가입"
        
        static let divider = "간편 회원가입/로그인"
    }
    
    // MARK: Image
    
    fileprivate struct Image {
        static let bgLogo = UIImage(named: "login_back_logo")
        
        static let passwordHidden = UIImage(named: "password_hidden_icon")
        static let passwordShow = UIImage(named: "password_show_icon")
        
        static let unCheckGray = UIImage(named: "uncheck_gray_icon")
        static let checkPrimary = UIImage(named: "check_primary_icon")
        
        static let logoGoogle = UIImage(named: "login_google_icon")
        static let logoKakao = UIImage(named: "login_kakao_icon")
        static let logoNaver = UIImage(named: "login_naver_icon")
        static let logoApple = UIImage(named: "login_apple_icon")
    }
    
    // MARK: Metric
    
    fileprivate struct Metric {
        
        static let logoLeftMargin = 110.f
        
        static let contentSideMargin = 20.f
        static let contentTopMargin = 42.f
        
        static let inputTopMargin = 30.f
        static let inputHeight = 50.f
        static let inputSpacing = 14.f
        static let inputRadius = 10.f
        static let inputLeft = 16.f
        
        static let autoTopMargin = 8.f
        static let autoSize = 34.f
        
        static let loginTopMargin = 8.f
        static let loginHeight = 50.f
        static let loginRadius = 10.f
        
        static let guideTopMargin = 24.f
        static let guidSpacing = 26.f
        
        static let snsGuideTopMargin = 156.f
        static let snsGuideDivider = 1.f
        static let snsGuideDividerBgHeight = 18.f
        static let snsGuideDividerSideMargin = 15.f
        
        static let snsListTopMargin = 24.f
        static let snsListSpacing = 24.f
        
        static let snsLogoSize = 40.f
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title = UIFont.getFont(size: 20, .semiBold)
        static let hint = UIFont.getFont(size: 14, .regular)
        static let autoLogin = UIFont.getFont(size: 14, .regular)
        
        static let login = UIFont.getFont(size: 16, .semiBold)
        static let guide = UIFont.getFont(size: 12, .regular)
        static let divider = UIFont.getFont(size: 12, .regular)
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let title = UIColor.white
        static let placeholder = UIColor(hexCode: "#919191")
        
        static let inputBg = UIColor(hexCode: "#252525")
        static let inputText = UIColor(hexCode: "#919191")
        
        static let offAutoLogin = UIColor(hexCode: "#484848")
        static let onAutoLogin = UIColor(hexCode: "#616FED")
        
        static let loginLabel = UIColor.black
        static let loginBg = UIColor(hexCode: "#616FED")
        
        static let guideLabel = UIColor(hexCode: "#919191")
    }
    
    // MARK: Ui
    
    // logo가 m자 탈모에 가려지는거 이야기하기
    private let ivLogo = UIImageView().then {
        $0.image = Image.bgLogo
    }
    
    private let viContent = UIView()
     
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.textColor = Color.title
        $0.font = Font.title
        $0.backgroundColor = .clear
        $0.numberOfLines = 2
    }
    
    private let stackInput = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.inputSpacing
    }
    
    private let tfId = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: Constant.idHint, attributes: [NSAttributedString.Key.foregroundColor: Color.inputText, NSAttributedString.Key.font: Font.hint])
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.inputLeft, height: 0))
        $0.leftViewMode = .always
        
        $0.borderColor = .clear
        $0.backgroundColor = Color.inputBg
        $0.textColor = Color.inputText
        $0.cornerRadius = Metric.inputRadius
    }
    
    private let tfPassword = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: Constant.passwordHint, attributes: [NSAttributedString.Key.foregroundColor: Color.inputText, NSAttributedString.Key.font: Font.hint])
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.inputLeft, height: 0))
        $0.leftViewMode = .always
        
        $0.borderColor = .clear
        $0.backgroundColor = Color.inputBg
        $0.textColor = Color.inputText
        $0.cornerRadius = Metric.inputRadius
    }
    
    private let btnAutoLogin = UIButton().then {
        $0.setTitle(Constant.autoLogin, for: .normal)
        $0.titleLabel?.font = Font.autoLogin
        
        // deselected 기본
        $0.setTitleColor(Color.offAutoLogin, for: .normal)
        $0.setImage(Image.unCheckGray, for: .normal)
        
        // selected
        $0.setTitleColor(Color.onAutoLogin, for: .selected)
        $0.setImage(Image.checkPrimary, for: .selected)
    }
    
    private let btnLogin = UIButton().then {
        $0.setTitle(Constant.login, for: .normal)
        $0.titleLabel?.font = Font.login
        $0.backgroundColor = Color.loginBg
        $0.setTitleColor(Color.loginLabel, for: .normal)
        $0.cornerRadius = Metric.loginRadius
    }
    
    private let stackGuide = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.spacing = Metric.guidSpacing
    }
    
    private let btnFindId = UIButton().then {
        $0.setTitle(Constant.findId, for: .normal)
        $0.titleLabel?.font = Font.guide
        $0.setTitleColor(Color.guideLabel, for: .normal)
    }
    
    private let btnResetPassword = UIButton().then {
        $0.setTitle(Constant.resetPassword, for: .normal)
        $0.titleLabel?.font = Font.guide
        $0.setTitleColor(Color.guideLabel, for: .normal)
    }
    
    private let btnRegister = UIButton().then {
        $0.setTitle(Constant.register, for: .normal)
        $0.titleLabel?.font = Font.guide
        $0.setTitleColor(Color.guideLabel, for: .normal)
    }
    
    private let viDivider = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let viDividerLabel = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let lbDivider = UILabel().then {
        $0.text = Constant.divider
        $0.textColor = .white
        $0.font = Font.divider
    }
    
    private let stackSocial = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metric.snsListSpacing
        $0.distribution = .equalCentering
        $0.alignment = .center
    }
    
    private let btnGoogleLogin = UIButton().then {
        $0.setImage(Image.logoGoogle, for: .normal)
        $0.cornerRadius = Metric.snsLogoSize / 2
    }
    
    private let btnKakaoLogin = UIButton().then {
        $0.setImage(Image.logoKakao, for: .normal)
        $0.cornerRadius = Metric.snsLogoSize / 2
    }
    
    private let btnNaverLogin = UIButton().then {
        $0.setImage(Image.logoNaver, for: .normal)
        $0.cornerRadius = Metric.snsLogoSize / 2
    }
    
    private let btnAppleLogin = UIButton().then {
        $0.setImage(Image.logoApple, for: .normal)
        $0.cornerRadius = Metric.snsLogoSize / 2
    }
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }        
        
        super.init()
        
        _ = [self.ivLogo, self.viContent].map {
            self.view.addSubview($0)
        }
        
        _ = [self.lbTitle, self.stackInput, self.btnAutoLogin, self.btnLogin, self.stackGuide,  self.viDivider, self.viDividerLabel, self.stackSocial].map {
            self.viContent.addSubview($0)
        }
        
        self.viDividerLabel.addSubview(self.lbDivider)
        
        self.setStackGuide()
        
        _ = [self.tfId, self.tfPassword].map {
            self.stackInput.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.height.equalTo(Metric.inputHeight)
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
        super.layoutNavigationViewItems()
        
    }
    
    private func setStackGuide() {
        _ = [self.btnFindId, self.btnResetPassword, self.btnRegister].map {
            self.stackGuide.addArrangedSubview($0)
        }
    }
    
    private func setStackSocial() {
        _ = [self.btnGoogleLogin, self.btnKakaoLogin, self.btnNaverLogin, self.btnAppleLogin].map {
            self.stackSocial.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.height.width.equalTo(Metric.snsLogoSize)
            }
        }
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        self.viContent.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.contentSideMargin)
            $0.top.equalTo(self.viNavigation.snp.bottom).offset(Metric.contentTopMargin)
            $0.bottom.equalToSuperview()
        }
        
        self.ivLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.logoLeftMargin)
            $0.top.trailing.equalToSuperview()
        }
        
        self.lbTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.stackInput.snp.makeConstraints {
            $0.top.equalTo(self.lbTitle.snp.bottom).offset(Metric.inputTopMargin)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.btnAutoLogin.snp.makeConstraints {
            $0.top.equalTo(self.stackInput.snp.bottom).offset(Metric.autoTopMargin)
            $0.leading.equalToSuperview()
            $0.height.equalTo(Metric.autoSize)
        }
        
        self.btnLogin.snp.makeConstraints {
            $0.top.equalTo(self.btnAutoLogin.snp.bottom).offset(Metric.loginTopMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.loginHeight)
        }
        
        self.stackGuide.snp.makeConstraints {
            $0.top.equalTo(self.btnLogin.snp.bottom).offset(Metric.guideTopMargin)
            $0.centerX.equalToSuperview()
        }
        
        self.viDivider.snp.makeConstraints {
            $0.top.equalTo(self.stackGuide.snp.bottom).offset(Metric.snsGuideTopMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.snsGuideDivider)
        }
        
        self.viDividerLabel.snp.makeConstraints {
            $0.centerY.centerX.equalTo(self.viDivider)
            $0.height.equalTo(Metric.snsGuideDividerBgHeight)
        }
        
        self.lbDivider.snp.makeConstraints {
            $0.top.bottom.equalTo(self.viDividerLabel)
            $0.leading.trailing.equalToSuperview().inset(Metric.snsGuideDividerSideMargin)
        }
        
        self.stackSocial.snp.makeConstraints {
            $0.top.equalTo(self.viDivider.snp.bottom).offset(Metric.snsListTopMargin)
            $0.height.equalTo(Metric.snsLogoSize)
            $0.centerX.equalToSuperview()
        }
        
        self.setStackSocial()
    }
    
    // MARK: - Bind
    
    public func bind(reactor: Reactor) {
        self.bindViews(reactor: reactor)
        self.bindState(reactor: reactor)
        self.bindActions(reactor: reactor)
    }
    
    // MARK: Bind Views
    
    public func bindViews(reactor: Reactor) {
        
    }
    
    // MARK: Bind State
    
    public func bindState(reactor: Reactor) {
        
        reactor.state
            .map { $0.id }
            .bind(to: self.tfId.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.password }
            .bind(to: self.tfPassword.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isAutoLogin }
            .bind(to: self.btnAutoLogin.rx.isSelected)
            .disposed(by: self.disposeBag)        
        
    }
    
    // MARK: Bind Action
    
    public func bindActions(reactor: Reactor) {
        
        self.btnLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputLogin)
            })
            .disposed(by: self.disposeBag)
        
        self.btnAutoLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputAutoLogin)
            })
            .disposed(by: self.disposeBag)
        
        self.btnFindId.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputFindId)
            })
            .disposed(by: self.disposeBag)
        
        self.btnResetPassword.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputResetPassword)
            })
            .disposed(by: self.disposeBag)
        
        self.btnRegister.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputRegister)
            })
            .disposed(by: self.disposeBag)
        
        self.btnGoogleLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputGoogle)
            })
            .disposed(by: self.disposeBag)
        
        self.btnKakaoLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputKakao)
            })
            .disposed(by: self.disposeBag)
        
        self.btnNaverLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputNaver)
            })
            .disposed(by: self.disposeBag)
        
        self.btnAppleLogin.rx.tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputApple)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
}
