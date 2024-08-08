//
//  EssayFollowingListView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/8/24.
//

import UIKit
import ReactorKit
import SnapKit

//public class EssayFollowingListView: BaseView, View {
//        
//    public typealias Reactor = ComunityReactor
//        
//    
//    fileprivate struct Constant {
//        static let title = "오늘의 글"
//        static let subTitle = "오늘 쓰여진 다양하고 솔직한 글들을 읽어보세요."
//    }
//    
//    public struct Metric {
//        static let borderHeight = 4.f
//    }
//    
//    fileprivate struct Font {
//        static let title: UIFont = .systemFont(ofSize: 16.0, weight: .semibold)
//    }
//    
//    fileprivate struct Color {
//        static let randomTitle: UIColor = .init(hexCode: "#616FED")
//        static let randomSubTitle: UIColor = .init(hexCode: "#696969")
//    }
//    
//    // MARK: UI
//    
//    
//    private let viContent = UIView().then {
//        $0.backgroundColor = .Theme.black
//    }
//    
//    private let lbTitle = UILabel().then {
//        $0.text = Constant.title
//        $0.font = Font.title
//        $0.textColor = Color.randomTitle
//    }
//    
//    private let lbSubTitle = UILabel().then {
//        $0.text = Constant.subTitle
//        $0.textColor = Color.randomSubTitle
//    }
//    
//    private let cvRandom = UICollectionView(
//        frame: .zero,
//        collectionViewLayout: UICollectionViewFlowLayout()
//    ).then {
//        $0.backgroundColor = .clear
//        $0.bounces = false
////        $0.register(EssayViewCell.self, forCellWithReuseIdentifier: Constant.essayCell)
//    }
//    
//    // MARK: Property
//    
//    public var disposeBag = DisposeBag()
//    
//    // MARK: - Initalize
//    init(
//        reactor: Reactor?
//    ) {
//        super.init()
//        self.backgroundColor = .Theme.black
//        
////        _ = [self.lbTitle, self.viBottomBar].map {
////            self.addSubview($0)
////        }
//        
//        self.setLayout()
//    }
//        
//    public required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: Bind
//    public func bind(reactor: Reactor) {
//        
//    }
//    
//    // MARK: Layout
//    
//    private func setLayout() {
//        self.addSubview(self.viContent)
//        
//        _ = [self.lbTitle, self.lbSubTitle, self.cvRandom].map {
//            self.viContent.addSubview($0)
//        }
//        
//        self.viContent.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview().inset(20.0)
//            $0.bottom.equalToSuperview().inset(10)
//        }
//        
//        self.lbTitle.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(26)
//            $0.leading.equalToSuperview()
//            $0.trailing.greaterThanOrEqualToSuperview()
//        }
//        
//        self.lbSubTitle.snp.makeConstraints {
//            $0.top.equalTo(self.lbTitle.snp.bottom)
//            $0.leading.equalToSuperview()
//            $0.trailing.greaterThanOrEqualToSuperview()
//        }
//        
//        self.cvRandom.snp.makeConstraints {
//            $0.top.equalTo(self.lbSubTitle.snp.bottom).offset(22.0)
//            $0.leading.trailing.equalToSuperview()
//        }
//    }
//
//}
