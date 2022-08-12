//
//  Comic.swift
//  marvel-app-swiftui
//
//  Created by Michal on 12/08/2022.
//

import Foundation

struct Comic: Codable, Hashable {
    
    public let title: String?
    public let description: String?
    public let urls: [Url]?
    public let thumbnail: Image?
    public let creators: CreatorList?
}

extension Comic{
    func getComicTitle(comic: Comic?) -> String{
        if let comic = comic, let title = comic.title{
            return title
        } else{
            return ComicConstants.noTitle
        }
    }

    func getAuthor(comic: Comic?) -> String{
        if let comic = comic, let creators = comic.creators, let items = creators.items, !items.isEmpty{
            for author in items {
                if (author.role == "writer"){
                    return "\(ComicConstants.writtenBy) \(author.name ?? "???")."
                }
            }
            return "\(ComicConstants.createdBy) \(items[0].name ?? "???")."
        } else{
            return ComicConstants.noAuthor
        }
    }

    func getDescription(comic: Comic?) -> String{
        if let comic = comic, let description = comic.description, !description.isEmpty{
            return description
        } else{
            return ComicConstants.noDescription
        }
    }

    func getCoverUrl(comic: Comic?) -> URL{
        guard let defaultUrl = URL(string: ComicConstants.baseImageUrl)else {
            return URL(string:"")!
        }

        if let comic = comic, let thumbnail = comic.thumbnail, let path = thumbnail.path, let ext = thumbnail.extension {
            return URL(string: "\(path).\(ext)".replacingOccurrences(of: "http", with: "https")) ?? defaultUrl
        } else {
            return defaultUrl
        }
    }
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }

        return attributedString.string
    }
}
