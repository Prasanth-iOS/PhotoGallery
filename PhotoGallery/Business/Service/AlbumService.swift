//
//  AlbumService.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

struct AlbumService {
    static func getAlbums(withSearchText keyword: [String: String]? = nil,
                          completion: @escaping AlbumsInfoCompletion) {
        do {
            try ConnectionTask(path: .getAlbumServicePath(with: keyword))
                .method(.get)
                .send { completion($0) }
        } catch {
            completion(.failure(error as! ConnectionError))
        }
    }
}
