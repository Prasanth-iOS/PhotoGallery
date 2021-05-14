//
//  PhotoService.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

struct PhotoService {
    static func getPhotos(forAlbum albumID: [String: String]? = nil,
                          completion: @escaping PhotoInfoCompletion) {
        do {
            try ConnectionTask(path: .getPhotoServicePath(with: albumID))
                .method(.get)
                .send { completion($0) }
        } catch {
            completion(.failure(error as! ConnectionError))
        }
    }
}
