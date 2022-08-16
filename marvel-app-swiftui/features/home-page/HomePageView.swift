//
//  ContentView.swift
//  marvel-app-swiftui
//
//  Created by Michal on 11/08/2022.
//

import SwiftUI

struct HomePageView: View {
    
    @StateObject private var viewModel = ViewModelsContainer.sharedContainer.container.resolve(HomePageViewModel.self)!
    
    var body: some View {
        
        NavigationView {
            ZStack {
                HomePageConstants.backgroundColor
                    .ignoresSafeArea()
                
                if !viewModel.dataFetched {
                    ProgressView()
                        .scaleEffect(x: 2, y: 2, anchor: .center)
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: HomePageConstants.stackSpacing) {
                        ForEach(viewModel.comics, id: \.self){ comic in
                            NavigationLink{
                                DetailsPageView(comic: comic)
                            } label: {
                                ComicsRow(comic: comic)
                            }
                        }
                    }
                }
                .task {
                    await viewModel.fetchComics()
                }
            }
            .navigationTitle(HomePageConstants.homePageTitle)
        }
        .navigationBarTitleDisplayMode(.automatic)
        
    }
    
    private func loadData(){
        Task {
            await viewModel.fetchComics()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro"], id: \.self) { deviceName in
                    HomePageView()
                        .previewDevice(PreviewDevice(rawValue: deviceName))
                }
    }
}
