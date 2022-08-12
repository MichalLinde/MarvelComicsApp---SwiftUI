//
//  ComicsRepository.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation

class ComicsRepository: ComicsRepositoryProtocol{
    
    var apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol){
        self.apiClient = apiClient
    }
    
    func fetchComic() async throws -> ComicDataWrapper{
        
        do {
            let data = try await apiClient.fetchComics()
            print("data fetched from api client")
            
            let comicDataWrapper = try JSONDecoder().decode(ComicDataWrapper.self, from: data)
            print("aaa")
            
            return comicDataWrapper
        } catch {
            throw FetchingError.failedFetching(message: "Failed in Repo")
        }
    }
}
