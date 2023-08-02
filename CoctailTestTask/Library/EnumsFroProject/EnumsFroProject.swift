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
    
    func currentSection(_ section: Int) -> Int {
        switch self {
        case .topBanner:
            return section
        case .menuList:
            return section - 1
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

