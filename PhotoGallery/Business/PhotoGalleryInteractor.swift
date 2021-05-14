//
//  PhotoGalleryInteractor.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

struct PhotoGalleryInteractor: PhotoGalleryBusinessInterface {
    func getAlbums(completion: @escaping AlbumsInfoCompletion) {
        AlbumService.getAlbums(completion: completion)
    }

    func getAlbums(withSearchText keyword: String,
                   completion: @escaping AlbumsInfoCompletion) {
        let searchDict = ["id": keyword]
        AlbumService.getAlbums(withSearchText: searchDict, completion: completion)
    }

    func getPhotos(forAlbum albumID: String, completion: @escaping PhotoInfoCompletion) {
        let searchDict = ["albumId": albumID]
        PhotoService.getPhotos(forAlbum: searchDict, completion: completion)
    }
}
