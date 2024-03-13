//
//  GlobalFunction.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI

func getFontSize(type: PostType) -> CGFloat {
    switch type {
    case .Header:
        return 24
    case .SubHeading:
        return 20
    case .Paragraph:
        return 18
    case .Image:
        return 18
    }
}
