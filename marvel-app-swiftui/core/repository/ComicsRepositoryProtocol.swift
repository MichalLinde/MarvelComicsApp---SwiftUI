//
//  ComicsRepositoryProtocol.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation

protocol ComicsRepositoryProtocol {
    func fetchComic() async throws -> ComicDataWrapper
}
