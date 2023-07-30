//
//  ApiURL.swift
//  CoctailTestTask
//
//  Created by APPLE on 24.06.2023.
//

import Foundation

enum API {
    
    static var categories: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thecocktaildb.com"
        components.path = "/api/json/v1/1/list.php"
        components.queryItems = [
            URLQueryItem(name: "c", value: "list")]
        return components.url
    }
    
    static func fetchCategory(category: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thecocktaildb.com"
        components.path = "/api/json/v1/1/filter.php"
        components.queryItems = [
            URLQueryItem(name: "c", value: category)]
        return components.url
    }
}
