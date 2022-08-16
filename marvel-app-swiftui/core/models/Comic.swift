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
    
    func getAllAuthors(comic: Comic?) -> String{
        if let comic = comic, let creators = comic.creators, let authors = creators.items, !authors.isEmpty{
            var authorsString = ""
            for author in authors {
                if let name = author.name{
                    authorsString += "\(name), "
                }
            }
            return String(authorsString.prefix(authorsString.count - 2))
        } else {
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

