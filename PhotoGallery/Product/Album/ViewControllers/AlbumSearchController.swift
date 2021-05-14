//
//  AlbumSearchController.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import UIKit

class AlbumSearchController: UISearchController {
    lazy var customSearchBar = CustomSearchBar(frame: CGRect.zero)

    override var searchBar: UISearchBar {
        customSearchBar.showsCancelButton = false
        return customSearchBar
    }
}

class CustomSearchBar: UISearchBar {
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
        super.setShowsCancelButton(false, animated: false)
    }
}
