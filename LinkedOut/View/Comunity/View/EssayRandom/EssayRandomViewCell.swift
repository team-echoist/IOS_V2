//
//  EssayRandomViewCell.swift
//  LinkedOut
//
//  Created by 이상하 on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import RxGesture
import SnapKit

public class EssayRandomViewCell: BaseCollectionViewCell, View {
        
    public typealias Reactor = EssayRandomViewCellReactor
    
    public var disposeBag = DisposeBag()
    
    // MARK: Dependency
    
    public struct Dependency {
        let imageOptions: ImageOptions
    }
    
    // MARK: Metric
    
    public struct Metric {
        static let baseCellHeihgt = 112.f
        
        static let topHeight = 24.f
        static let topSpacing = 8.f
        
        static let linkedOutSize = 24.f
        
        static let thumbnailSize = 102.f
        static let thumbnailRadius = 10.f
        
        static let thumbnailLeftMargin = 13.f
        
        static let contentPadding = 20.f
        static let contentTopMargin = 10.f
    }
    
    // MARK: Color
    
    public struct Color {
        static let background: UIColor = .Theme.black
        static let dateText: UIColor = .Theme.gray01
        
        static let authorNickname: UIColor = .init(hexCode: "#686868")
    }
    
    // MARK Font
    
    public struct Font {
        static let title: UIFont = .systemFont(ofSize: 14, weight: .medium)
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
        $0.numberOfLines = 2
        $0.font = Font.content
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .justified
    }
    
    private let lbCreateDate = UILabel().then {
        $0.textColor = Color.dateText
        $0.font = Font.createDate
    }
    
    private let lbAuthorNickname = UILabel().then {
        $0.font = Font.content
        $0.textColor = Color.authorNickname
    }
    
    private let viDivier = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.2)
    }
    
    private let ivThumbnail = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = Metric.thumbnailRadius
    }
        
    // MARK: Property
    public var dependency: Dependency?

    // MARK: Initialize
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = Color.background
        
        self.contentView.addSubview(self.viContent)
        
        let _ = [self.ivThumbnail, self.viTop, self.lbContent, self.viDivier, self.lbAuthorNickname].map {
            self.viContent.addSubview($0)
        }
        
        let _ = [self.lbTitle, self.lbCreateDate].map {
            self.viTop.addSubview($0)
        }
                
        super.addTapHandler()
    }
    
    // MARK: Configure
    
    public func bind(reactor: Reactor) {
        guard let dependency = self.dependency else { preconditionFailure() }
        
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
        
        self.setNeedsLayout()
    }
    
    // MARK: Size

    /// cell 고유 사이즈가 필요한 경우에 사용
    public class func size(width: CGFloat, reactor: EssayRandomViewCellReactor) -> CGSize {
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
            $0.height.equalTo(Metric.topHeight)
            $0.leading.trailing.top.equalToSuperview()
        }
        
        self.lbTitle.snp.remakeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        self.lbCreateDate.snp.remakeConstraints {
            $0.centerY.equalTo(self.lbTitle)
            $0.leading.equalTo(self.lbTitle.snp.trailing).offset(6.f)
            $0.trailing.greaterThanOrEqualToSuperview()
        }
        
        self.lbContent.snp.remakeConstraints {
            $0.top.equalTo(self.viTop.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
        }
        
        self.ivThumbnail.snp.remakeConstraints {
            $0.centerY.equalTo(self.lbContent)
            $0.leading.equalTo(self.lbContent.snp.trailing).offset(Metric.thumbnailLeftMargin)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(Metric.thumbnailSize)
        }
        
        self.viDivier.snp.remakeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
    
    public func setLayout() {
        
    }
}
