//
//  EnumsFroProject.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import UIKit

enum Category: Int, CaseIterable {
    case cocktail
    case coffeeTea
    case shot
    case beer
    case coffee
    case shake
    
    var name: String {
        switch self {
        case .cocktail:
            return "Cocktail"
        case .coffeeTea:
            return "Coffee / Tea"
        case .shot:
            return "Shot"
        case .beer:
            return "Beer"
        case .coffee:
            return "Кофе"
        case .shake:
            return "Shake"
        }
    }
}

enum TypeSection: Int, CaseIterable {
    case topBanner
    case coffeeTea
    case shot
    case beer
    case shake
    
    var typeCell: TypeCell {
        switch self {
        case .topBanner:
            return .topBannerCell
        default:
            return .menuCell
        }
    }

    var name: String {
        switch self {
        case .coffeeTea:
            return "Coffee / Tea"
        case .shot:
            return "Shot"
        case .beer:
            return "Beer"
        case .shake:
            return "Shake"
        default:
            return""
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

