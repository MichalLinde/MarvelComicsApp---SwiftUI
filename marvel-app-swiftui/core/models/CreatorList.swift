//
//  CreatorList.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//


struct CreatorList: Codable, Hashable {
    public let available: Int?
    public let returned: Int?
    public let collectionURI: String?
    public let items: [CreatorSummary]?
}
