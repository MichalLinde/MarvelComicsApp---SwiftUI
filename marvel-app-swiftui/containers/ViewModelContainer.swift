//
//  ViewModelContainer.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation
import Swinject

class ViewModelsContainer {
    static let sharedContainer = ViewModelsContainer()
    
    let container = Container()
    
    private init(){
        setupContainers()
    }
    
    func setupContainers(){
        let repoContainer = RepositoryContainer.sharedContainer.container
        
        container.register(HomePageViewModel.self) { _ in
            return HomePageViewModel(repo: repoContainer.resolve(ComicsRepositoryProtocol.self)!)
        }
    }
}
