//
//  PhotoGalleryBusinessInterface.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

public typealias AlbumsInfoCompletion = (Result<[Album], ConnectionError>) -> Void
public typealias PhotoInfoCompletion = (Result<[Photo], ConnectionError>) -> Void

/// Interface for interactor with the module
public protocol PhotoGalleryBusinessInterface {
    func getAlbums(completion: @escaping AlbumsInfoCompletion)
    func getAlbums(withSearchText keyword: String,
                   completion: @escaping AlbumsInfoCompletion)
    func getPhotos(forAlbum albumID: String,
                   completion: @escaping PhotoInfoCompletion)
}

/// Global var to interact with any Module
public var galleryBusiness: PhotoGalleryBusinessInterface {
    return PhotoGalleryInteractor()
}
