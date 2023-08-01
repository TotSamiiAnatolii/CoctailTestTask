//
//  EnumsFroProject.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

enum TypeSection: Int, CaseIterable {
    
    case topBanner
    case menuList
    
    var typeCell: TypeCell {
        switch self {
        case .topBanner:
            return .topBannerCell
        default:
            return .menuCell
        }
    }
}

enum StateScroll {
    case userInteracts
    case programScroll
}

enum TypeCell: Int {
    case topBannerCell
    case menuCell
    case category
}

enum State {
    case load
    case error(Error)
}

enum StateDowload {
    case loading
    case downloadFinished
}

enum StateHeader {
    case floats
    case stiky
}

enum CategoryType: Int {
    case topBanner
    case menu
}

