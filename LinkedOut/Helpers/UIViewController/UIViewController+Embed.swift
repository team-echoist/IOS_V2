//
//  UIViewController+Embed.swift
//  LinkedOut
//
//  Created by 이상하 on 7/25/24.
//

import UIKit


extension UIViewController {
    func embed(_ vc: UIViewController, in _containerView: UIView? = nil) {
        let containerView: UIView = _containerView ?? view // Use the whole view if no container view is provided.
        containerView.addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        ])
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        vc.didMove(toParent: self)
    }
}

