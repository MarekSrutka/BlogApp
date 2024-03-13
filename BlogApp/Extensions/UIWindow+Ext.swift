//
//  UIWindow+Ext.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
