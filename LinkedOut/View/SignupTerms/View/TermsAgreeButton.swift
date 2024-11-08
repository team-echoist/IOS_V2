//
//  TermsAgreeButton.swift
//  LinkedOut
//
//  Created by 이상하 on 10/31/24.
//

import UIKit
import ReactorKit
import RxSwift
import SnapKit
import Then

class TermsAgreeButton: UIButton, View {
    
    typealias Reactor = TermsAgreeButtonReactor
    var disposeBag = DisposeBag()
    
    // MARK: Image
    
    fileprivate struct Image {
        static let agreeCheck = UIImage(named: "check_primary_icon")
        static let agreeUncheck = UIImage(named: "uncheck_gray_icon")
        
        static let grayInfo = UIImage(named: "gray_info_icon")
    }
    
    // MARK: Font
    
    fileprivate struct Font {        
        static let agree = UIFont.getFont(size: 14.f, .regular)
    }
    
    // MARK: Metric
    
    fileprivate struct Metric {
        static let agreeSpacing = 8.f
        static let agreeSize = 34.f
        
        static let infoSize = 26.f
        static let infoLeftMargin = 16.f
    }
    
    // MARK: Color
    
    fileprivate struct Color {        
        static let agreeFont = UIColor(hexCode: "#919191")
    }
    
    // MARK: UI
    
    private let ivSelect = UIImageView().then {
        $0.image = Image.agreeUncheck
    }
    
    private let lbTitle = UILabel().then {
        $0.font = Font.agree
        $0.textColor = Color.agreeFont
    }
    
    private let btnInfo = UIButton().then {
        $0.setImage(Image.grayInfo, for: .normal)
    }
    
    // MARK: property
        
    // MARK: - Initialize
    
    init(reactor: Reactor) {
        defer { self.reactor = reactor}
        super.init(frame: .zero)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func setUpUI() {
        _ = [self.ivSelect, self.lbTitle, self.btnInfo].map {
            self.addSubview($0)
        }
        
        self.ivSelect.snp.makeConstraints {
            $0.height.width.equalTo(Metric.agreeSize)
            $0.leading.top.bottom.equalToSuperview()
        }
        
        self.lbTitle.snp.remakeConstraints {
            $0.leading.equalTo(self.ivSelect.snp.trailing).offset(Metric.agreeSpacing)
            $0.centerY.equalTo(self.ivSelect)
        }
        
        self.btnInfo.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(self.lbTitle.snp.trailing).offset(Metric.infoLeftMargin)
            $0.width.height.equalTo(Metric.infoSize)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(self.ivSelect)
        }
    }
    
    private func updateUI() {
        
    }
    
    // MARK: Size
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        return CGSize(width: 0, height: 0)
    }
    
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Bind
    
    func bind(reactor: Reactor) {
        self.bindState(reactor: reactor)
        self.bindAction(reactor: reactor)
        self.bindView(reactor: reactor)
    }
    
    private func bindState(reactor: Reactor) {
        reactor.state.map { $0.title }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.lbTitle.text = $0
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isSelected }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.ivSelect.image = $0 == true ? Image.agreeCheck : Image.agreeUncheck
            })
            .disposed(by: self.disposeBag)
    }
    
    private func bindAction(reactor: Reactor) {
//        상위 뷰에서 toggle 중
//        self.rx.tap.subscribe(onNext: {
//            reactor.action.onNext(.toggleAgreeButton())
//        })
//        .disposed(by: self.disposeBag)
        
        self.btnInfo.rx.tap.subscribe(onNext: {
            reactor.action.onNext(.inputInfo)
        })
        .disposed(by: self.disposeBag)
    }
    
    private func bindView(reactor: Reactor) {
        
        reactor.state.map { $0.hasLink }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.btnInfo.isHidden = !$0
                self.lbTitle.snp.remakeConstraints {
                    $0.leading.equalTo(self.ivSelect.snp.trailing).offset(Metric.agreeSpacing)
                    $0.centerY.equalTo(self.ivSelect)
                    $0.trailing.equalToSuperview().inset(Metric.agreeSpacing)
                }
            }).disposed(by: self.disposeBag)                
    }
}
