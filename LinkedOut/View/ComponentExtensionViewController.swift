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

public protocol ComponentExtensionViewControllerViewControllerType {
    
}

public final class ComponentExtensionViewControllerViewController: BaseViewControllerA, ComponentExtensionViewControllerViewControllerType {
    
    // MARK: Constant
        
        fileprivate struct Constant {
        }
        
        // MARK: Initialize
        
        public init(
        ) {
            
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
        
        // MARK: Bind
        
        public func bind(reactor: Reactor) {

        }
        
        // MARK: Event


        // MARK: Action
}
