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
        
        static let tempSave = "저장"
    }
    
    // MARK: Metric
        
    fileprivate struct Metric {
        static let navigationMargin = 20.f
        static let tfTitleSideMargin = 6.f
        static let dividerHeight = 1.f
        
        static let contentsTopMargin = 26.f
        static let contentsSideMargin = 20.f
        
        static let textEditorHeight = 50.f
        static let editIconSize = 30.f
        static let editIconLeftMargin = 20.f
        static let editIconSpacing = 14.f
        static let editIconStackRightMargin = 8.f
        
        static let editSaveAndHideSpacing = 12.f
        static let tempSaveSize = 30.f
        static let editHideSize = 30.f
        static let editDividerVerticalMargin = 8.f
    }
    
    // MARK: Image
    
    fileprivate struct Image {
        static let size = UIImage(named: "text_size")
        static let bold = UIImage(named: "text_bold")
        static let underline = UIImage(named: "text_underline")
        static let strikethrough = UIImage(named: "text_strikethrough")
        static let addEtc = UIImage(named: "add_circle_white")
        
        static let hideEdit = UIImage(named: "right_arrow_thin")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let cancel = UIFont.getFont(size: 14, .regular)
        static let complete = UIFont.getFont(size: 16, .regular)
        static let title = UIFont.getFont(size: 16, .regular)
        static let contents = UIFont.getFont(size: 16, .regular)
        
        static let tempSave = UIFont.getFont(size: 16, .regular)
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
        static let editorDivider = UIColor(hexCode: "#ffffff", alpha: 0.2)
        
        static let textEditorBg = UIColor(hexCode: "#1D1D1D")
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
    
    private let viTextEditor = UIView().then {
        $0.backgroundColor = Color.textEditorBg
        $0.isHidden = true
    }
    
    private let viEditIconStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metric.editIconSpacing
    }
    
    private let viSaveAndHideEdit = UIView()
    
    private let btnTempSave = UIButton().then {
        $0.setTitle(Constant.tempSave, for: .normal)
        $0.titleLabel?.font = Font.tempSave
        $0.tintColor = .white
    }

    private let btnHideEdit = UIButton().then {
        $0.setImage(Image.hideEdit, for: .normal)
    }
    
    let viEditorDivider = UIView().then {
        $0.backgroundColor = Color.divider
    }
    
    // MARK: - property
    
    let textEditorIcons = [Image.size, Image.bold, Image.underline, Image.strikethrough, Image.addEtc]
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        _ = [self.viTitleNavigation, self.viDivider, self.tvContents, self.viTextEditor].map {
            self.view.addSubview($0)
        }
        
        // 텍스트 데이터 창
        _ = [self.viEditIconStack, self.viSaveAndHideEdit].map {
            self.viTextEditor.addSubview($0)
        }
                        
        
        _ = self.textEditorIcons.map {
            let button = UIButton()
            button.setImage($0, for: .normal)
            self.viEditIconStack.addArrangedSubview(button)
            button.snp.makeConstraints {
                $0.width.height.equalTo(Metric.editIconSize)
            }
        }
        
        _ = [self.btnTempSave, self.viEditorDivider, self.btnHideEdit].map {
            self.viSaveAndHideEdit.addSubview($0)
        }
        
        
        // 상단 네비게이션
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
        
        // 텍스트 데이터
        self.viTextEditor.snp.makeConstraints {
            $0.height.equalTo(Metric.textEditorHeight)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.viEditIconStack.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Metric.editIconLeftMargin)
            $0.height.equalTo(Metric.editIconSize)
            $0.centerY.equalToSuperview()
        }
        
        self.viSaveAndHideEdit.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(self.viEditIconStack.snp.trailing).offset(Metric.editIconStackRightMargin)
        }
        
        self.btnTempSave.snp.makeConstraints {
            $0.height.width.equalTo(Metric.tempSaveSize)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.viEditorDivider.snp.makeConstraints {
            $0.leading.equalTo(self.btnTempSave.snp.trailing ).offset(Metric.editSaveAndHideSpacing)
            $0.height.equalTo(Metric.textEditorHeight)
            $0.width.equalTo(1.f)
            $0.top.bottom.equalToSuperview().inset(Metric.editDividerVerticalMargin)
        }
        
        self.btnHideEdit.snp.makeConstraints {
            $0.height.width.equalTo(Metric.editHideSize)
            $0.leading.equalTo(self.viEditorDivider.snp.trailing ).offset(Metric.editSaveAndHideSpacing)
            $0.trailing.equalToSuperview().inset(Metric.editSaveAndHideSpacing)
            $0.centerY.equalToSuperview()
        }
        
        _ = [self.btnTempSave, self.viEditorDivider, self.btnHideEdit].map {
            self.viSaveAndHideEdit.addSubview($0)
        }
    }
    
    // MARK: - Bind
    
    public func bind(reactor: Reactor) {
        self.bindView(reactor)
        self.bindAction(reactor)
        self.bindState(reactor)
    }
    
    // MARK: Bind - View
    public func bindView(_ reactor: Reactor) {
        self.tvContents.rx
            .attributedText
            .filterNil()
            .bind(onNext: { text in
                reactor.action.onNext(.inputContentField(text))
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - Action
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
        
        self.btnTempSave.rx
            .tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputTempSave)
                self.view.endEditing(true)
            })
            .disposed(by: self.disposeBag)
        
        self.btnHideEdit.rx
            .tap
            .subscribe(onNext: {
                reactor.action.onNext(.inputHideEdit)
                self.view.endEditing(true)
            })
            .disposed(by: self.disposeBag)
        
        // keyboard 액션
        NotificationCenter.rx.keyboardNotification()
            .map { .keyboardStateChanged(height: $0.0, isVisible: $0.1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        self.bindErrorState(reactor)
        self.bindAlertState(reactor)
        self.bindKeyboardState(reactor)
    }
    
    private func bindErrorState(_ reactor: Reactor) {
        reactor.state
            .map { $0.error }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.showAlert(message: $0.title )
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindAlertState(_ reactor: Reactor) {
        reactor.state
            .map { $0.alert }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.showAlert(message: $0.localized )
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindKeyboardState(_ reactor: Reactor) {
        reactor.state
            .map { !$0.isKeyboardVisible }
            .bind(to: self.viTextEditor.rx.isHidden )
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.keyboardHeight }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] height in
                guard let self = self else { return }
                if height > 0.0 {
                    self.viTextEditor.snp.updateConstraints {
                        $0.bottom.equalToSuperview().inset(height)
                    }
                } else {
                    self.viTextEditor.snp.updateConstraints {
                        $0.bottom.equalToSuperview()
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
}
