//
//  AlbumListViewModel.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

protocol AlbumResultDelegate: class {
    func updateAlbumList()
}

class AlbumListViewModel {
    weak var delegate: AlbumResultDelegate?
    var albums = [Album]() {
        didSet {
            delegate?.updateAlbumList()
        }
    }
    var error: ConnectionError?

    func getAlbums(withSearchText keyword: String? = nil) {
        if let searchText = keyword {
            galleryBusiness.getAlbums(withSearchText: searchText) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let albums):
                    strongSelf.albums = albums
                case .failure(let error):
                    strongSelf.error = error
                }
            }
        } else {
            galleryBusiness.getAlbums { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let albums):
                    strongSelf.albums = albums
                case .failure(let error):
                    strongSelf.error = error
                }
            }
        }
    }
}
