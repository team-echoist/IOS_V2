//
//  EssayViewCell.swift
//  LinkedOut
//
//  Created by 이상하 on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxGesture
import SnapKit
import Kingfisher

public class EssayViewCell: BaseCollectionViewCell, View {
    
    
    public var disposeBag = DisposeBag()
            
    // MARK: Types
    
    public typealias Reactor = EssayViewCellReactor
    
    // MARK: Dependency
    
    public struct Dependency {
        let imageOptions: ImageOptions
    }
    
    // MARK: Metric
    
    public struct Metric {
        static let baseCellHeihgt = 180.f
    }
    
    // MARK: Color
    
    public struct Color {
        static let background: UIColor = .Theme.black
        static let dateText: UIColor = .Theme.gray01
    }
    
    // MARK Font
    
    public struct Font {
        static let title: UIFont = .systemFont(ofSize: 20, weight: .semibold)
        static let content: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let createDate: UIFont = .systemFont(ofSize: 10, weight: .regular)
    }
    
    // MARK: Image
    
    public struct Image {
        static let option = UIImage(named: "option_dot")
    }
    
    // MARK: UI
    
    private let viContent = UIView()
    
    private let viTop = UIView()
    
    private let lbTitle = UILabel().then {
        $0.textColor = .white
        $0.font = Font.title
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let lbContent = UILabel().then {
        $0.textColor = .white
        $0.numberOfLines = 3
        $0.font = Font.content
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .justified
    }
    
    private let btnOption = UIButton().then {
        $0.setImage(Image.option, for: .normal)
    }
    
    private let lbCreateDate = UILabel().then {
        $0.textColor = Color.dateText
        $0.font = Font.createDate
    }
    
    private let viDivier = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.2)
    }
    
    private let ivThumbnail = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
        
    // MARK: Property
    public var dependency: Dependency?

    // MARK: Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = Color.background
        
        self.contentView.addSubview(self.viContent)
        
        let _ = [self.ivThumbnail, self.viTop, self.lbContent, self.lbCreateDate, self.viDivier].map {
            self.viContent.addSubview($0)
        }
        
        let _ = [self.lbTitle, self.btnOption].map {
            self.viTop.addSubview($0)
        }
                
        super.addTapHandler()
    }
    
    // MARK: Configure
    
    public func bind(reactor: Reactor) {
        guard let dependency = self.dependency else { preconditionFailure() }
        
        self.bindState(reactor)
        self.bindView(reactor)
        
        self.setNeedsLayout()
    }
    
    // MARK: Bind - State
    public func bindState(_ reactor: Reactor) {
        reactor.state.map { $0.title }
            .bind(to: self.lbTitle.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.content }
            .bind(to: self.lbContent.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.createdDate }
            .bind(to: self.lbCreateDate.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.thumbnail }
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if let urlString = $0, let url = URL(string: urlString) {
                    self.ivThumbnail.kf.setImage(with: url)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Bind - View
    public func bindView(_ reactor: Reactor) {
        self.btnTapHandler.rx.tap
            .subscribe(onNext: { _ in
                reactor.action.onNext(.inputTapEssay(essayId: reactor.currentState.id))
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Size

    /// cell 고유 사이즈가 필요한 경우에 사용
    public class func size(width: CGFloat, reactor: EssayViewCellReactor) -> CGSize {
        let baseHeight = CGFloat(Metric.baseCellHeihgt)
        
        return CGSize(width: width, height: baseHeight)
    }
    
    // MARK: Layout

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viContent.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        self.viTop.snp.remakeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        self.ivThumbnail.snp.remakeConstraints {
            $0.edges.equalTo(self.viContent)
            $0.width.height.equalTo(self.viContent)
        }
        
        self.lbTitle.snp.remakeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalTo(self.btnOption.snp.leading).offset(8)
        }
        
        self.btnOption.snp.remakeConstraints {
            $0.width.height.equalTo(30)
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        self.lbContent.snp.remakeConstraints {
            $0.top.equalTo(self.viTop.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.lbCreateDate.snp.remakeConstraints {
            $0.top.equalTo(self.lbContent.snp.bottom).offset(10)
            $0.trailing.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
        self.viDivier.snp.remakeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    public func setLayout() {
        
    }
}
