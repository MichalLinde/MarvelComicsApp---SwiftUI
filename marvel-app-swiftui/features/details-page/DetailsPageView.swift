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
                BottomSheet(isOpen: $presentSheet, maxHeight: geometry.size.height * DetailsPageConstants.maxSheetHeight){
                    
                    GeometryReader { geomtry in
                        VStack(alignment: .leading, spacing: DetailsPageConstants.textStackSpacing){
                            Text(comic?.getComicTitle(comic: comic) ?? ComicConstants.noTitle)
                                .font(.system(size: DetailsPageConstants.titleFontSize, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text(comic?.getAllAuthors(comic: comic) ?? ComicConstants.noAuthor)
                                .font(.system(size: DetailsPageConstants.authorFontSize))
                                .foregroundColor(.gray)
                            
                            Text(comic?.getDescription(comic: comic) ?? ComicConstants.noDescription)
                                .font(.system(size: DetailsPageConstants.descriptionFontSize))
                                .foregroundColor(.black)

                        }
                        .padding(.horizontal)
                        .frame(minWidth: .zero, maxWidth: geometry.size.width, alignment: .topLeading)
                    }
                    
                }
                
            }
            .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                Button(action: {
                    openURL(getComicsUrl(comic: comic))
                }){
                    Text(DetailsPageConstants.moreButtonText)
                        .background(Color.red)
                        .cornerRadius(DetailsPageConstants.moreButtonRadius)
                        .font(.system(size: DetailsPageConstants.moreButtonFontSize, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: DetailsPageConstants.moreButtonHeight)
                }
                .background(Color.red)
                .cornerRadius(DetailsPageConstants.moreButtonRadius)
                .frame(width: .infinity, height: DetailsPageConstants.moreButtonHeight)
                .padding([.leading, .trailing], DetailsPageConstants.moreButtonHorizontalPadding)
                .padding([.bottom], DetailsPageConstants.moreButtonBottomPadding)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(DetailsPageConstants.pageTitle)
    }
    
    
    private func getComicsUrl(comic: Comic?) -> URL {
        if let comic = comic, let urls = comic.urls, !urls.isEmpty{
            if let stringUrl = urls[0].url, let url = URL(string: stringUrl){
                return url
            }
        }
        return URL(string: DetailsPageConstants.defaultUrl)!
    }
}

struct DetailsPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsPageView()
    }
}
