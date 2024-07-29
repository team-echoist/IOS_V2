//
//  ViewController+Alert.swift
//  
//
//  Created by 정윤호 on 2017. 3. 29..
//  Copyright © 2017년 Foodinko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    private func getAddNewLine(_ message: String) -> String {
        let addNewline = message
        
//        if message.contains("\n") {
//            addNewline = message + "\n"
//        }
//        addNewline = message + "\n\n"
        
        return addNewline
    }

    public func showAlert(title: String  = "", message: String) {
        let alertController = UIAlertController(title: title, message: self.getAddNewLine(message), preferredStyle: .alert)
        let action = UIAlertAction(title: LocalizeString.ok.rawValue.localized, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String  = "", message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: self.getAddNewLine(message), preferredStyle: .alert)
        let action =  UIAlertAction(title: LocalizeString.ok.rawValue.localized, style: .default) { action in
            completion()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String  = "", message: String, align: NSTextAlignment, confirm: @escaping () -> Void, cancel: @escaping () -> Void) {
        self.showAlert(title: title, message: message, titleOk: LocalizeString.yes.rawValue.localized, titleCancel: LocalizeString.no.rawValue.localized, align: align, confirm: confirm, cancel: cancel)
    }
    
    public func showAlert(title: String  = "", message: String, titleOk: String, titleCancel: String, align: NSTextAlignment, confirm: @escaping () -> Void, cancel: @escaping () -> Void) {
        let alertController: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = align
        
        let messageText = NSMutableAttributedString(
            string: self.getAddNewLine(message),
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                //NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
        )
        alertController.setValue(messageText, forKey: "attributedMessage")
        
        
        let confirmAction: UIAlertAction
            = UIAlertAction(title: titleOk, style: .default) { action -> Void in
                confirm()
        }
        let cancelAction: UIAlertAction
            = UIAlertAction(title: titleCancel, style: .cancel) { action -> Void in
                cancel()
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    public func showAlert(title: String, message: String, button1: String, button2: String, button3: String, align: NSTextAlignment, button1Completion: @escaping () -> Void, button2Completion: @escaping () -> Void, button3Completion: @escaping () -> Void) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = align
        
        let messageText = NSMutableAttributedString(
            string: self.getAddNewLine(message),
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                //NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
        )
        alertController.setValue(messageText, forKey: "attributedMessage")
        
        
        let button1Action: UIAlertAction
            = UIAlertAction(title: button1, style: .default) { action -> Void in
                button1Completion()
        }
        alertController.addAction(button1Action)
        
        
        let button2Action: UIAlertAction
            = UIAlertAction(title: button2, style: .cancel) { action -> Void in
                button2Completion()
        }
        alertController.addAction(button2Action)
        
        if !button3.isEmpty {
            let button3Action: UIAlertAction
                = UIAlertAction(title: button3, style: .cancel) { action -> Void in
                    button3Completion()
            }
            alertController.addAction(button3Action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
