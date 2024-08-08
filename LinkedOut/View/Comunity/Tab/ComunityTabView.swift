//
//  ComunityTabView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/6/24.
//

import Foundation
import UIKit
import Then
import SnapKit

public class ComunityTabView: BaseView {
    
    fileprivate struct Constant {
        
    }
    
    public struct Metric {
        static let borderHeight = 4.f
    }
    
    fileprivate struct Font {
        static let tab: UIFont = .systemFont(ofSize: 14.0, weight: .regular)
    }
    
    fileprivate struct Color {
        static let tab = UIColor(hexCode: "#262626")
    }
    
    // MARK: UI
    
    private let lbTitle = UILabel().then {
        $0.textColor = .Theme.subTitleBlack
        $0.font = Font.tab
    }
    
    private let viBottomBar = UIView().then {
        $0.backgroundColor = Color.tab
        
    }
    
    // MARK: Property
    
    var tabData: ComunityTabType?
    
    // MARK: Initalize
    
    init(
        tabData: ComunityTabType
    ) {
        super.init()
        
        _ = [self.lbTitle, self.viBottomBar].map {
            self.addSubview($0)
        }
        
        self.setLayout()
        self.setTabData(tabData: tabData)
    }
        
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Bind
    
    // MARK: Layout
    
    private func setLayout() {
        self.lbTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(4.0)
        }
        
        self.viBottomBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(Metric.borderHeight)
        }
    }
    
    public func setTabData(tabData: ComunityTabType) {
        self.tabData = tabData;
        
        self.lbTitle.text = tabData.rawValue
    }
    
    public func setSelected() {
        self.viBottomBar.isHidden = false
    }
    
    public func setDeselected() {
        self.viBottomBar.isHidden = true
    }
}
