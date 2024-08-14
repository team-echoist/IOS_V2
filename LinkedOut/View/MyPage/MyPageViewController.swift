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

public protocol MyPageViewControllerType {
    
}

public final class MyPageViewController: BaseViewController, MyPageViewControllerType, View {
    
    public typealias Reactor = MyPageReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
        static let title = "MY"
        static let writing = "쓴 글"
        static let posted = "발행"
        static let linkedout = "링크드 아웃"
        static let editProfile = "프로필 편집"
        static let linkedoutBadge = "링크드아웃 배지"
        static let recentRead = "최근 본 글"
        static let manageMemgership = "멤버십 관리"
        static let manageAccount = "계정 관리"
        static let memberShipReady = "준비중"
    }
    
    // MARK: Metric
        
    fileprivate struct Metric {
        static let navHeight = 36.f
        static let navSideMargin = 20.f
        static let navTitleRightMargin = 10.f
        
        static let contentSideMargin = 20.f
        
        static let profileImageSize = 108.f
        static let profileImageTopMargin = 36.f
        static let nicknameTopMargin = 10.f
                
        static let profileCountRadius = 10.f
        static let profileCountHeight = 62.f;
        static let profileCountTopMargin = 16.f
        
        static let profileEditRadius = 10.f;
        static let profileEditHeight = 50.f;
        static let profileEditTopMargin = 10.f;
        
        static let arrowSize = 24.f
        
        static let listSpacing = 50.f
        static let listTopMargin = 32.f
        static let listLabelHeight = 27.f
        
        static let memberShipHeight = 24.f
        static let memberShipRadius = 10.f
        static let memberShipSidePading = 14.f
    }
    
    // MARK: Image
        
    fileprivate struct Image {
        static let emptyProfile = UIImage(named: "empty_profile")
        static let rightArrow = UIImage(named: "right_arrow_gray")
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let background: UIColor = .init(hexCode: "#D9D9D9")
        static let nickname: UIColor = .init(hexCode: "#616FED")
        static let listTitle: UIColor = .init(hexCode: "#616FED")
        static let profileCountBg: UIColor = .init(hexCode: "#0D0D0D")
        
        static let count: UIColor = .init(hexCode: "#616161")
        static let countDivider: UIColor = .init(hexCode: "#191919")
        static let profileEditBg: UIColor = .init(hexCode: "#616FED")
        
        static let memberShipBg: UIColor = .init(hexCode: "#191919")
        static let memberShipFg: UIColor = .init(hexCode: "#616FED")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title: UIFont = .getFont(size: 24.0, .bold)
        static let nickname: UIFont = .getFont(size: 24.0, .bold)
        static let listTitle: UIFont = .getFont(size: 16.0, .semiBold)
        static let editProfile: UIFont = .getFont(size: 14.0, .semiBold)
        
        static let countTitle: UIFont = .getFont(size: 10.0, .regular)
        static let countNumber: UIFont = .getFont(size: 18.0, .medium)
        
        static let memberShip: UIFont = .getFont(size: 12.0, .semiBold)
    }
    
    // MARK: - UI
    
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.textColor = .white
        $0.font = Font.title
    }
    
    private let viScroll = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
    }
    
    private let viContent = UIView()
    
    private let viScrollContent = UIView()
    
    private let ivProfile = UIImageView().then {
        $0.image = Image.emptyProfile
        $0.cornerRadius = Metric.profileImageSize / 2
    }
    
    private let lbNickname = UILabel().then {
        $0.text = MyInfoManager.shared.myInfo?.nickname
        $0.textColor = .white
        $0.font = Font.nickname
    }
    
    private let viProfile = UIView()
    
    private let viCountStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.backgroundColor = Color.profileCountBg
        $0.cornerRadius = Metric.profileCountRadius
    }
    
    private let btnEditProfile = UIButton().then {
        $0.setTitle(Constant.editProfile, for: .normal)
        $0.backgroundColor = Color.profileEditBg
        $0.cornerRadius = Metric.profileEditRadius
        $0.titleLabel?.font = Font.editProfile
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let viListStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.listSpacing
    }
    
    private let viMemberShip = UIView().then {
        $0.backgroundColor = Color.memberShipBg
        $0.cornerRadius = Metric.memberShipRadius
        
        let label = UILabel()
        label.text = Constant.memberShipReady
        label.textColor = Color.memberShipFg
        label.font = Font.memberShip
        
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.memberShipSidePading)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        $0.snp.makeConstraints {
            $0.height.equalTo(Metric.memberShipHeight)
        }
    }
    
    // MARK: Property
    
    let listItem = [Constant.linkedoutBadge, Constant.recentRead, Constant.manageMemgership, Constant.manageAccount]
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor
    ) {
        defer { self.reactor = reactor }
        super.init()
        
        self.viNavigation.addSubview(self.lbTitle)
        
        self.view.addSubview(self.viScroll)
        self.viScroll.addSubview(self.viScrollContent)
        self.viScroll.addSubview(self.viContent)
        
        _ = [self.ivProfile, self.lbNickname, self.viCountStack, self.btnEditProfile, self.viListStack].map {
            self.viContent.addSubview($0)
        }
                        
        _ = MyPageModel.ListItem.allCases.map {
            let view = self.makeTitleLabelView($0)
            self.viListStack.addArrangedSubview(view)
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
            $0.leading.trailing.equalToSuperview().inset(Metric.navSideMargin)
            $0.centerY.equalToSuperview()
        }
        
        self.viScroll.snp.makeConstraints {
            $0.top.equalTo(self.viNavigation.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.viScrollContent.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        self.viContent.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Metric.contentSideMargin)
        }
        
        self.ivProfile.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.profileImageTopMargin)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(Metric.profileImageSize)
        }
        
        self.lbNickname.snp.makeConstraints {
            $0.centerX.equalTo(self.ivProfile)
            $0.top.equalTo(self.ivProfile.snp.bottom).offset(Metric.nicknameTopMargin)
        }
        
        self.viCountStack.snp.makeConstraints {
            $0.top.equalTo(self.lbNickname.snp.bottom).offset(Metric.profileCountTopMargin)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.profileCountHeight)
        }
        
        self.btnEditProfile.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.viCountStack.snp.bottom).offset(Metric.profileEditTopMargin)
            $0.height.equalTo(Metric.profileEditHeight)
        }
        
        self.viListStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.btnEditProfile.snp.bottom).offset(Metric.listTopMargin)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func makeTitleLabelView(_ data: MyPageModel.ListItem) -> UIView {
        let vi = UIStackView()
        vi.distribution = .equalCentering
        vi.alignment = .fill
        
        let label = UILabel()
        label.text = data.rawValue
        label.textColor = Color.listTitle
        label.font = Font.listTitle
        label.snp.makeConstraints {
            $0.height.equalTo(Metric.listLabelHeight)
        }
        
        let ivArrow = UIImageView(image: Image.rightArrow)
        ivArrow.snp.makeConstraints {
            $0.height.width.equalTo(Metric.arrowSize)
        }
        
        let viewList = data == .membership ? [label, self.viMemberShip] : [label, ivArrow]
        
        _ = viewList.map {
            vi.addArrangedSubview($0)
        }
        
        vi.rx.tapGesture()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.reactor?.action.onNext(.onTapListItem(data))
            })
            .disposed(by: self.disposeBag)
        
        return vi
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindState(reactor)
        self.bindView(reactor)
    }
    
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        
        reactor.state
            .map { $0.summaryData }
            .subscribe(onNext: { [weak self] list in
                guard let self = self else { return }
                if list.count == self.viCountStack.arrangedSubviews.count { return }
                
                let _ = list.map {
                    let stack = UIStackView()
                    stack.axis = .vertical
                    stack.alignment = .center
                    stack.distribution = .fillProportionally
                    
                    let titleLabel = UILabel()
                    titleLabel.text = $0.type.rawValue
                    titleLabel.font = Font.countTitle
                    titleLabel.textColor = Color.count
                    
                    titleLabel.snp.makeConstraints {
                        $0.height.equalTo(15.f)
                    }
                    
                    let countLabel = UILabel()
                    countLabel.text = String($0.count)
                    countLabel.font = Font.countNumber
                    countLabel.textColor = Color.count
                    
                    stack.addArrangedSubview(titleLabel)
                    stack.addArrangedSubview(countLabel)
                    stack.snp.makeConstraints {
                        $0.height.equalTo(Metric.profileCountHeight)
                    }
                    
                    self.viCountStack.addArrangedSubview(stack)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - View
    public func bindView(_ reactor: Reactor) {
        self.btnEditProfile.rx.tap
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputProfileEdit)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
}
