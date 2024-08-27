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

public protocol EssayDetailViewControllerType {
    
}

public final class EssayDetailViewController: BaseViewController, EssayDetailViewControllerType, View {
    
    public typealias Reactor = EssayDetailReactor
    
    // MARK: Constant
        
    fileprivate struct Constant {
        
    }
    
    // MARK: Metric
        
    fileprivate struct Metric {
        static let optionMargin = 20.f
        static let optionSize = 30.f
        
        static let thumbnailHeight = 220.f
        
        static let titleHeight = 67.f
        static let titleSideMargin = 20.f
        static let titleTopMargin = 34.f
        static let titleBottomMargin = 10.f
        
        static let contentMargin = 20.f
        static let authorTopMargin = 44.f
        static let authorSideMargin = 20.f
        static let createdTopMargin = 8.f
        static let createdSideMargin = 20.f
        
    }
    
    // MARK: Image
    
    fileprivate struct Image {
        static let option = UIImage(named: "option_dot")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title = UIFont.getFont(size: 20, .semiBold)
        static let content = UIFont.getFont(size: 16, .regular)
        static let author = UIFont.getFont(size: 12, .regular)
        static let createdDate = UIFont.getFont(size: 12, .regular)
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let titleBg = UIColor.black
        static let content = UIColor(hexCode: "#B4B4B4")
        static let author = UIColor(hexCode: "#686868")
        static let createdDate = UIColor(hexCode: "#686868")
    }
    
    // MARK: Ui
    
    private let btnOption = UIButton().then {
        $0.setImage(Image.option, for: .normal)
    }
    
    private let ivThumbnail = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    private let viTitle = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let lbTitle = UILabel().then {
        $0.font = Font.title
        $0.textColor = .white
    }
    
    private let lbContent = UILabel().then {
        $0.font = Font.content
        $0.textColor = Color.content
        $0.numberOfLines = 0
        $0.textAlignment = .justified
    }
    
    private let lbAuthor = UILabel().then {
        $0.font = Font.author
        $0.textColor = Color.author
        $0.textAlignment = .right
    }
    
    private let lbCreatedDate = UILabel().then {
        $0.font = Font.createdDate
        $0.textColor = Color.createdDate
        $0.textAlignment = .right
    }
    
    // MARK: property
    private let essayId: Int
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor,
        essayId: Int
    ) {
        defer { self.reactor = reactor }
        self.essayId = essayId
        super.init()
        
        self.viNavigation.addSubview(self.btnOption)
        
        _ = [self.ivThumbnail, self.viTitle, self.lbContent, self.lbAuthor, self.lbCreatedDate].map {
            self.view.addSubview($0)
        }
        
        self.viTitle.addSubview(self.lbTitle)
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
        log.debug("essay detail layout common")
        
        self.btnOption.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Metric.optionMargin)
            $0.width.height.equalTo(Metric.optionSize)
        }
        
        self.viTitle.snp.makeConstraints {
            $0.top.equalTo(self.viNavigation.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.titleHeight)
        }
        
        self.lbTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.titleTopMargin)
            $0.bottom.equalToSuperview().inset(Metric.titleBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.titleSideMargin)
        }
        
        self.lbContent.snp.makeConstraints {
            $0.top.equalTo(self.viTitle.snp.bottom).offset(Metric.contentMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentMargin)
        }
        
        self.lbAuthor.snp.makeConstraints {
            $0.top.equalTo(self.lbContent.snp.bottom).offset(Metric.authorTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.authorSideMargin)
        }
        
        self.lbCreatedDate.snp.makeConstraints {
            $0.top.equalTo(self.lbAuthor.snp.bottom).offset(Metric.createdTopMargin)
            $0.trailing.equalToSuperview().inset(Metric.createdSideMargin)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    private func setThumbnailView() {
        self.ivThumbnail.snp.remakeConstraints {
            $0.top.equalTo(self.viNavigation.snp.bottom)
            $0.height.equalTo(Metric.thumbnailHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.viTitle.snp.remakeConstraints {
            $0.top.equalTo(self.ivThumbnail.snp.top).offset(Metric.thumbnailHeight - Metric.titleHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.titleHeight)
        }
        
        let gradientview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: Metric.titleHeight)))
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientview.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradient.locations = [0.3, 1]
        gradientview.layer.insertSublayer(gradient, at: 0)
        self.viTitle.addSubview(gradientview)
        self.viTitle.sendSubviewToBack(gradientview)
        
        gradientview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.lbTitle.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(Metric.titleTopMargin)
            $0.bottom.equalToSuperview().inset(Metric.titleBottomMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.titleSideMargin)
        }
        
        self.lbContent.snp.remakeConstraints {
            $0.top.equalTo(self.ivThumbnail.snp.bottom).offset(Metric.contentMargin)
            $0.leading.trailing.equalToSuperview().inset(Metric.contentMargin)
        }
    }
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindView(reactor)
        self.bindState(reactor)
        
        reactor.action.onNext(.loadEssay(self.essayId))
    }
    
    // MARK: Bind - State
    
    public func bindState(_ reactor: Reactor) {
        self.bindStateEssay(reactor)
        self.bindStateAlert(reactor)
        self.bindStateError(reactor)
    }
    
    public func bindStateEssay(_ reactor: Reactor) {
        
        reactor.state
            .map { $0.essay }
            .filterNil()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.lbTitle.text = $0.title
                self.lbContent.text = $0.content
                self.lbAuthor.text = $0.author?.nickname ?? "-"
                self.lbCreatedDate.text = $0.createdDate
                
                if let urlString = $0.thumbnail, let url = URL(string: urlString) {
                    self.ivThumbnail.isHidden = false
                    self.setThumbnailView()
                    self.ivThumbnail.kf.setImage(with: url) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let value):
                                self.ivThumbnail.image = value.image
                                self.view.layoutIfNeeded()
                            case .failure(_):
                                self.ivThumbnail.image = nil
                            }
                            
                        }
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindStateAlert(_ reactor: Reactor) {
        reactor.state
            .map { $0.alert }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] message in
                guard let self = self else { return }
                self.showAlert(message: message.localized)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindStateError(_ reactor: Reactor) {
        reactor.state
            .map { $0.error }.filterNil()
            .mapChangedTracked({ $0 }).filterNil()
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(message: error.description)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - View
    
    public func bindView(_ reactor: Reactor) {
        self.btnBack.rx.tap
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputBack)
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Event


    // MARK: Action
}
