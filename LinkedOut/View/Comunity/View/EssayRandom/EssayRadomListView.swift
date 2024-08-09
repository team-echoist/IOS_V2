//
//  EssayRadomListView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/7/24.
//

import UIKit
import ReactorKit
import SnapKit
import RxDataSources

public class EssayRandomListView: BaseView, View {
        
    public typealias Reactor = ComunityReactor
    
    public typealias DataSource = RxCollectionViewSectionedReloadDataSource<EssayRandomSection>
        
    // MARK: Constant
    
    fileprivate struct Constant {
        static let essayRandomCell = "essayRandomCell"
        
        static let title = "오늘의 글"
        static let subTitle = "오늘 쓰여진 다양하고 솔직한 글들을 읽어보세요."
    }
    
    // MARK: Metric
    
    public struct Metric {
        static let borderHeight = 4.f
        
        static let sectionLineSpacing = 0.f
        static let sectionInsetLeftRight = 20.f
        static let sectionInteritemSpacing = 0.f
        
        static let contentSideMargin = 20.f
        static let contentBottomMargin = 10.f
        
        static let titleTopMargin = 26.f
        static let listTopMargin = 22.f
    }
    
    // MARK: Font
    
    fileprivate struct Font {
        static let title: UIFont = .systemFont(ofSize: 16.0, weight: .semibold)
    }
    
    // MARK: Color
    
    fileprivate struct Color {
        static let randomTitle: UIColor = .init(hexCode: "#616FED")
        static let randomSubTitle: UIColor = .init(hexCode: "#696969")
    }
    
    // MARK: UI
    
    
    private let viContent = UIView().then {
        $0.backgroundColor = .Theme.black
    }
    
    private let lbTitle = UILabel().then {
        $0.text = Constant.title
        $0.font = Font.title
        $0.textColor = Color.randomTitle
    }
    
    private let lbSubTitle = UILabel().then {
        $0.text = Constant.subTitle
        $0.textColor = Color.randomSubTitle
    }
    
    private let cvRandom = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.bounces = false
        $0.register(EssayRandomViewCell.self, forCellWithReuseIdentifier: Constant.essayRandomCell)
        $0.isPrefetchingEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: Property
    
    public var disposeBag = DisposeBag()
    
    fileprivate let dataSource: DataSource

    
    // MARK: - Initalize
    init(
        reactor: Reactor?,
        randomCellDependency: EssayRandomViewCell.Dependency
    ) {
        defer { self.reactor = reactor }
        self.dataSource = type(of: self).dataSourceFactory(cellDependency: randomCellDependency)

        super.init()
        self.backgroundColor = .Theme.black
        
        self.setLayout()
    }
        
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Data Source Factory
    
    private static func dataSourceFactory(cellDependency: EssayRandomViewCell.Dependency) -> DataSource {
        return .init(
            configureCell: { datasource, collectionview, indexPath, sectionItem in
                switch sectionItem {
                case .essayRandomViewCellReactor(let reactor):
                    let cell = collectionview.dequeueReusableCell(withReuseIdentifier: Constant.essayRandomCell, for: indexPath) as! EssayRandomViewCell
                    
                    cell.dependency = cellDependency
                    cell.reactor = reactor
                    
                    return cell
                }
            }
        )
    }
    
    // MARK: Bind
    public func bind(reactor: Reactor) {
        self.bindView(reactor)
    }
    
    // MARK: Bind - view
    
    public func bindView(_ reactor: Reactor) {
        self.cvRandom.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.essayList }
            .bind(to: self.cvRandom.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Layout
    
    private func setLayout() {
        self.addSubview(self.viContent)
        
        _ = [self.lbTitle, self.lbSubTitle, self.cvRandom].map {
            self.viContent.addSubview($0)
        }
        
        self.viContent.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Metric.contentSideMargin)
            $0.bottom.equalToSuperview().inset(Metric.contentBottomMargin)
        }
        
        self.lbTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Metric.titleTopMargin)
            $0.leading.equalToSuperview()
            $0.trailing.greaterThanOrEqualToSuperview()
        }
        
        self.lbSubTitle.snp.makeConstraints {
            $0.top.equalTo(self.lbTitle.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.greaterThanOrEqualToSuperview()
        }
        
        self.cvRandom.snp.makeConstraints {
            $0.top.equalTo(self.lbSubTitle.snp.bottom).offset(Metric.listTopMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

// MARK: Extension - UICollectionViewDelegateFlowLayout

extension EssayRandomListView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch self.dataSource[section] {
            case .items:
                let topBottom = Metric.sectionLineSpacing
                let leftRight = Metric.sectionInsetLeftRight
            return UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionItem = self.dataSource[section]
        switch sectionItem {
            case .items:
            return Metric.sectionLineSpacing
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch self.dataSource[section] {
            case .items:
                return Metric.sectionInteritemSpacing
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionItem = self.dataSource[indexPath]
        switch sectionItem {
        case .essayRandomViewCellReactor(let reactor):
            return EssayRandomViewCell.size(width: self.width - (Metric.sectionInsetLeftRight * 2), reactor: reactor)
        }
    }


    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.isDetectEdgesBottom() {
//            self.loadNextPage()
//        }
    }
}
