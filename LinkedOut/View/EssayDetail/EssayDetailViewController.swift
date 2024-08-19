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
    
    // MARK: Image
    
    fileprivate struct Image {
        static let option = UIImage(named: "option_dot")
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title = UIFont.getFont(size: 20, .semiBold)
        static let content = UIFont.getFont(size: 16, .regular)
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let content = UIColor(hexCode: "#B4B4B4")
    }
    
    // MARK: Ui
    
    private let ivThumbnail = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let lbTitle = UILabel().then {
        $0.font = Font.title
        $0.textColor = .white
    }
    
    private let lbContent = UILabel().then {
        $0.font = Font.content
        $0.textColor = Color.content
    }
    
    // MARK: - Initialize
    
    public init(
        reactor: Reactor,
        essayId: Int
    ) {
        defer { self.reactor = reactor }
        super.init()
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
    
    // MARK: Bind
    
    public func bind(reactor: Reactor) {
        self.bindView(reactor)
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
