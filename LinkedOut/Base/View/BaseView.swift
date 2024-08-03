//
//  BaseView.swift
//  LinkedOut
//
//  Created by 이상하 on 8/4/24.
//

import Foundation
import UIKit
import ManualLayout
import SnapKit

open class BaseView: UIView {
    
    
    // MARK: Constant
    
    // MARK: UI
    
    // MARK: Property
    
    
    // MARK: Initialize
    public init() {
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: Configure
    
    open func setUpUI() {
        
    }
    
    open func updateUI() {
        
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
}

