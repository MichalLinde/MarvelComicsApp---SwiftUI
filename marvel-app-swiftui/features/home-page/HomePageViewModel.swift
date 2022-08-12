//
//  HomePageViewModel.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation

class HomePageViewModel: ObservableObject {
    let repo: ComicsRepositoryProtocol
    
    init(repo: ComicsRepositoryProtocol) {
        self.repo = repo
    }
    
    @Published var comics: [Comic] = []
    @Published var dataFetched: Bool = false
    
    func fetchComics() async {
        dataFetched = false
        do {
            let comicsFetched = try await repo.fetchComic()
            if let data = comicsFetched.data, let results = data.results {
                comics = results
                dataFetched = true
            }
        } catch {
            print("Error fetching data in viewmodel")
        }
    }
}

