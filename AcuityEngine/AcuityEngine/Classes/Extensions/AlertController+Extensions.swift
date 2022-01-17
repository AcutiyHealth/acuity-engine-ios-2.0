//
//  AlertController+Extensions.swift
//  AcuityEngine
//
//  Created by Bhoomi Jagani on 11/01/22.
//

import Foundation
import UIKit

private var associationKey: UInt8 = 0

extension UIAlertController {

    private var alertWindow: UIWindow! {
        get {
            return objc_getAssociatedObject(self, &associationKey) as? UIWindow
        }

        set(newValue) {
            objc_setAssociatedObject(self, &associationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func showOnWindow() {
        self.alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        self.alertWindow.backgroundColor = .red

        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        self.alertWindow.rootViewController = viewController

        let topWindow = UIApplication.shared.windows.last
        if let topWindow = topWindow {
            self.alertWindow.windowLevel = topWindow.windowLevel + 1
        }

        self.alertWindow.makeKeyAndVisible()
        self.alertWindow.rootViewController?.present(self, animated: true, completion: nil)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.alertWindow.isHidden = true
        self.alertWindow = nil
    }
}
