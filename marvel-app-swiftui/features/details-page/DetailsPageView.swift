//
//  DetailsPageView.swift
//  marvel-app-swiftui
//
//  Created by Michal on 16/08/2022.
//

import SwiftUI

struct DetailsPageView: View {
    
    var comic: Comic?
    @State var presentSheet = false
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack(alignment: .top){
            AsyncImage(
                url: comic?.getCoverUrl(comic: comic)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            GeometryReader { geometry in
                BottomSheet(isOpen: $presentSheet, maxHeight: geometry.size.height * 0.85){
                    
                    GeometryReader { geomtry in
                        VStack(alignment: .leading, spacing: 5){
                            Text(comic?.getComicTitle(comic: comic) ?? ComicConstants.noTitle)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text(comic?.getAllAuthors(comic: comic) ?? ComicConstants.noAuthor)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text(comic?.getDescription(comic: comic) ?? ComicConstants.noDescription)
                                .font(.system(size: 16))
                                .foregroundColor(.black)

                        }
                        .padding(.horizontal)
                        .frame(minWidth: 0, maxWidth: geometry.size.width, alignment: .topLeading)
                    }
                    
                }
                
            }
            .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                Button(action: {
                    openURL(getComicsUrl(comic: comic))
                }){
                    Text("Find out more")
                        .background(Color.red)
                        .cornerRadius(5)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(Color.red)
                .cornerRadius(5)
                .frame(width: .infinity, height: 60)
                .padding([.leading, .trailing], 15)
                .padding([.bottom], 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
    }
    
    
    private func getComicsUrl(comic: Comic?) -> URL {
        if let comic = comic, let urls = comic.urls, !urls.isEmpty{
            if let stringUrl = urls[0].url, let url = URL(string: stringUrl){
                return url
            }
        }
        return URL(string: "https://www.marvel.com/")!
    }
}

struct DetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPageView()
    }
}
