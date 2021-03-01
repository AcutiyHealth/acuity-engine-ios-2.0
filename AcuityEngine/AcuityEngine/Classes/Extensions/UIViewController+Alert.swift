//
//  UIViewController+Alert.swift
//  learnIt
//
//  Created by TRT-IOS-1 on 12/12/19.
//  Copyright © 2019 TechGadol. All rights reserved.
//


import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String?, sourceView: UIView?, okAction: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okActionItem = UIAlertAction(title: "Ok", style: .default) { (_) in
            okAction?()
        }
        alert.addAction(okActionItem)
        
        if isiPhone() == true{
            alert.modalPresentationStyle = .popover
            alert.popoverPresentationController?.sourceView = sourceView
            alert.popoverPresentationController?.sourceRect = sourceView?.frame ?? .zero
        }
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String, actions: UIAlertAction...) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

