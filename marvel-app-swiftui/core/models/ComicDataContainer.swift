//
//  ComicDataContainer.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation

struct ComicDataContainer: Codable {
    public let offset: Int?
    public let limit: Int?
    public let total: Int?
    public let count: Int?
    public let results: [Comic]?
}
