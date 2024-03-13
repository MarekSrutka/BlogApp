//
//  UIScreen+Ext.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import Foundation
import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
