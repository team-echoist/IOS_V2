//
//  BaseViewController.swift
//  LinkedOut
//
//  Created by 이상하 on 7/24/24.
//

import UIKit
import RxSwift
import SnapKit
import ManualLayout


public protocol BaseViewControllerType {
    
}


open class BaseViewController: UIViewController, BaseViewControllerType, NVActivityIndicatorViewable {
    
    // MARK: Rx
    
    public var disposeBag = DisposeBag()
    
    // MARK: Constant
    
    fileprivate struct Constant {
        //static let collectionViewEmpty = "empty"
        //static let sectionColumnCount = isPad() ? 6 : 2
        //static let sortColumns: [LocalizeString] = [.SortColumnRegistDate, .SortColumnOnStudy, .SortColumnNewStudy]
        static let messageInitial = " "
    }
    
    fileprivate struct Metric {
        static let navigationTitleBottom = -20
        static let titleKernValue = -0.5
        static let backButtonBottom = 20
    }
    
    fileprivate struct Font {
//        static let title = UtilFont.getPretendardBoldFont(size: 18)
    }
    
    public struct AttributedText {
//        static let title = UtilFont.getAttributeString(
//            string: Constant.messageInitial,
//            font: Font.title,
//            foregroundColor: Color.title,
//            kernValue: Metric.titleKernValue
//        )
    }
    
    fileprivate struct Color {
        static let title = UIColor.black
        static let bg = UIColor.Theme.black
    }
    
    fileprivate struct Image {
        static let back = UIImage(named: "title_back")
    }
    
    // MARK: Property
    
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    // MARK: Status Bar
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: UI
    
    public let viNavigation = UIView().then {
        $0.backgroundColor = .clear
    }
    
    public let labNavigationTitle = UILabel().then {
//        $0.attributedText = AttributedText.title
        $0.textAlignment = .center
    }
    
    public let btnBack = UIButton().then {
        $0.setImage(Image.back, for: .normal)
        $0.isHidden = true
    }

    // MARK: Initialize
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
        log.debug("DEINIT: \(self.className)")
    }

    // MARK: View Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.updateUI()
        
        self.view.setNeedsUpdateConstraints()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Layout
    
    private(set) var didSetupConstraints = false

    override open func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    open func setupConstraints() {
        // Override point
        
        self.layoutCommon()
        
        if isPhone() {
            self.layoutPhone()
        } else if isPad() {
            self.layoutPad()
        } else {
            log.debug("simulator")
        }

    }
    
    /// iPhone/iPad 디바이스 구분 없는 레이아웃일 경우
    open func layoutCommon() {
        self.layoutNavigationView()
    }
    
    /// iPhone
    open func layoutPhone() {
    }
    
    /// iPad
    open func layoutPad() {
    }
    
    /// Top Guide Line
    open func layoutGuideLinesTop() -> ConstraintItem {
        return self.viNavigation.snp.bottom
    }
    
    open func layoutNavigationView() {
        viNavigation.snp.remakeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(UtilsScreen.getSizeNavigationBar())
        }
    }
    
    /// SEE: FoodinNewDetailViewController
    /// Legacy: navigationToSuperView@BaseViewController
    open func layoutNavigationViewToStatusBar() {
        viNavigation.snp.remakeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalToSuperview()
            let height = UtilsScreen.getSizeNavigationBarToStatusBar()
            $0.height.equalTo(height)
        }
    }
    
    open func layoutNavigationViewItems() {
        self.labNavigationTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(Metric.navigationTitleBottom)
            $0.centerY.equalToSuperview()
        }
        self.btnBack.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(Metric.backButtonBottom)
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Configure
    
    open func setUpUI() {
        self.view.backgroundColor = Color.bg
        self.setUpNavigation()
    }
    
    private func setUpNavigation() {
        self.view.addSubview(self.viNavigation)
        self.viNavigation.addSubview(self.labNavigationTitle)
        self.viNavigation.addSubview(self.btnBack)
    }
    
    open func updateUI() {
        self.updateNavigationTitle()
        self.updateAvailableBack()
    }
    
    open func updateNavigationTitle() {}
    
    open func updateAvailableBack() {}
    
    // MARK: Event


    // MARK: Action
    
}

