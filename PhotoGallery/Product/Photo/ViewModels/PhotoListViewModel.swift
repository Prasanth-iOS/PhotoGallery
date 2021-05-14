//
//  PhotoListViewModel.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

protocol PhotoResultDelegate: class {
    func updatePhotoList()
}

class PhotoListViewModel {
    weak var delegate: PhotoResultDelegate?
    var photos = [Photo]() {
        didSet {
            delegate?.updatePhotoList()
        }
    }
    var error: ConnectionError?
    var albumID: String?

    func getPhotos() {
        guard let id = albumID else {
            return
        }
        galleryBusiness.getPhotos(forAlbum: id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let photos):
                strongSelf.photos = photos
            case .failure(let error):
                strongSelf.error = error
            }
        }
    }
}
