//
//  WritingTabView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import UIKit

public class WritingTabView: BaseView {
    
    fileprivate struct Constant {
        
    }
    
    public struct Metric {
        static let borderHeight = 4.f
    }
    
    fileprivate struct Font {
        static let tab: UIFont = .systemFont(ofSize: 14.0, weight: .regular)
    }
    
    fileprivate struct Color {
        static let deselet = UIColor(hexCode: "#686868")
    }
    
    // MARK: UI
    
    private let lbTitle = UILabel().then {
        $0.textColor = .white
        $0.font = Font.tab
    }
    
    private let viBottomBar = UIView().then {
        $0.backgroundColor = .white        
    }
    
    // MARK: Property
    
    var tabData: WritingTabModel?
    
    // MARK: Initalize
    
    init(
        tabData: WritingTabModel?
    ) {
        super.init()
        
        _ = [self.lbTitle, self.viBottomBar].map {
            self.addSubview($0)
        }
        
        self.setLayout()
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
    
    public func setTabData(tabData: WritingTabModel) {
        self.tabData = tabData;
        
        self.lbTitle.text = tabData.title
        if tabData.selected {
            self.setSelected()
        } else {
            self.setDeselected()
        }
    }
    
    public func setSelected() {
        self.lbTitle.textColor = .white
        self.viBottomBar.isHidden = false
    }
    
    public func setDeselected() {
        self.lbTitle.textColor = Color.deselet
        self.viBottomBar.isHidden = true
    }
    
    
}
