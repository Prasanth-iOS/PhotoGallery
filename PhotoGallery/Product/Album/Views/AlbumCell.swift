//
//  AlbumCell.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    static let reuseIdentifier = String(describing: AlbumCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        let bundle = Bundle(for: AlbumCell.self)
        return UINib(nibName: String(describing: AlbumCell.self), bundle: bundle)
    }

    static func register(with collectionView: UICollectionView) {
        collectionView.register(nib(), forCellWithReuseIdentifier: reuseIdentifier)
    }

    func configure(withTitle title: String) {
        self.title.text = title
    }
}
