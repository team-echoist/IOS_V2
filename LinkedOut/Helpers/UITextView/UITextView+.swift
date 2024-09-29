//
//  UITextView+.swift
//  LinkedOut
//
//  Created by 이상하 on 9/2/24.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextView {
    var selectedTextRange: Observable<String?> {
        return base.rx.methodInvoked(#selector(UITextViewDelegate.textViewDidChangeSelection(_:)))
            .map { [weak base] _ in
                guard let base = base else { return nil }
                let selectedRange = base.selectedTextRange
                return base.text(in: selectedRange ?? UITextRange())
            }
    }

    var selectedText: Observable<String?> {
        return didChangeSelection
            .map { [weak base] in base?.text(in: base?.selectedTextRange ?? UITextRange()) }
    }
}

extension UITextView {
    func text(from nsRange: NSRange) -> String? {
        let nsText = (text as NSString)
        
        guard nsRange.location != NSNotFound && nsRange.location + nsRange.length <= nsText.length else {
            return nil
        }
        
        return nsText.substring(with: nsRange)
    }
}
