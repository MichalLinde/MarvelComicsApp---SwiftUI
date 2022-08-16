//
//  ComicsRow.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import SwiftUI

struct ComicsRow: View {
    
    var comic: Comic?
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            HStack(alignment: .top) {
                AsyncImage(
                    url: comic?.getCoverUrl(comic: comic)){ image in
                            image.resizable()
                                .frame(width: ComicsRowConstants.imageWidth)
                                
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(RoundedRectangle(cornerRadius: ComicsRowConstants.cornerRadius))
                        
                VStack (alignment: .leading){
                    Text(comic?.getComicTitle(comic: comic) ?? ComicConstants.noTitle)
                        .font(.system(size: ComicsRowConstants.titleFontSize, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: ComicsRowConstants.titleTopPadding, leading: .zero, bottom: .zero, trailing: .zero))
                        
                    Text(comic?.getAuthor(comic: comic) ?? ComicConstants.noAuthor)
                            .font(.system(size: ComicsRowConstants.authorFontSize))
                            .foregroundColor(.gray)
                            .lineLimit(.zero)
                            .multilineTextAlignment(.leading)
                        
                    Text(comic?.getDescription(comic: comic) ?? ComicConstants.noDescription)
                            .font(.system(size: ComicsRowConstants.descriptionFontSize))
                            .foregroundColor(.black)
                            .lineLimit(ComicsRowConstants.descriptionMaxLines)
                            .multilineTextAlignment(.leading)
                    }
                .padding(ComicsRowConstants.textStackPadding)
                }
                .clipShape(RoundedRectangle(cornerRadius: ComicsRowConstants.cornerRadius))
        }
        .frame(height: ComicsRowConstants.rowHeight)
        .clipShape(RoundedRectangle(cornerRadius: ComicsRowConstants.cornerRadius))
        .padding(EdgeInsets(top: .zero, leading: ComicsRowConstants.rowHorizontalPadding, bottom: .zero, trailing: ComicsRowConstants.rowHorizontalPadding))
        .shadow(radius: ComicsRowConstants.rowShadowRadius)
        
        
    }
    
}

struct ComicsRow_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro"], id: \.self) { deviceName in
                    ComicsRow()
                        .previewDevice(PreviewDevice(rawValue: deviceName))
                }
    }
}
