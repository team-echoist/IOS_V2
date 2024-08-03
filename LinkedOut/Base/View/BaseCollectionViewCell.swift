// 
//  BaseCollectionViewCell.swift
//  LinkedOut
//
//  Created by 이상하 on 8/1/24.
//

import UIKit


open class BaseCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Initialize
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }

    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
    }
    
    // MARK: UI
    
    public let btnTapHandler = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    public func addTapHandler() {
//        self.btnTapHandler.addTarget(self, action: #selector(onTapHandler), for: .touchUpInside)
        self.contentView.addSubview(self.btnTapHandler)
        self.btnTapHandler.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
//    @objc public func onTapHandler() {
//        log.debug("onTapHandler")
//        self.dispatchTapHandler()
//    }
    
//    open func dispatchTapHandler() {}

}
