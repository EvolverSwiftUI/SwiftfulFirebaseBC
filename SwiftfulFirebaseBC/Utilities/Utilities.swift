//
//  Utilities.swift
//  SwiftfulFirebaseBC
//
//  Created by Sivaramaiah NAKKA on 25/03/23.
//

import UIKit

final class Utilities {
    static let instance = Utilities()
    private init() { }
    
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }

        return controller
    }
}
