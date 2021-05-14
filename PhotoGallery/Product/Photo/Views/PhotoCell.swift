//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var title: UILabel!

    // MARK: - Properties
    static let reuseIdentifier = String(describing: PhotoCell.self)
    private var imageDownloader = ImageDownloader()
    private var screenScale: CGFloat { return UIScreen.main.scale }

    // MARK: - Lifetime
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupContainerView()
    }

    static func nib() -> UINib {
        let bundle = Bundle(for: AlbumCell.self)
        return UINib(nibName: String(describing: PhotoCell.self), bundle: bundle)
    }

    static func register(with collectionView: UICollectionView) {
        collectionView.register(nib(), forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        imageView.backgroundColor = .clear
        imageView.image = nil
        imageDownloader.cancel()
    }

    // MARK: - Setup
    private func setupContainerView() {
        contentView.preservesSuperviewLayoutMargins = true
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with photo: Photo) {
        title.text = photo.title
        downloadImage(with: photo.thumbnailUrl)
    }

    private func downloadImage(with urlString: String?) {
        guard let string = urlString, let url = URL(string: string) else { return }

        imageDownloader.downloadPhoto(with: url, completion: { [weak self] (image, isCached) in
            guard let strongSelf = self, strongSelf.imageDownloader.isCancelled == false else { return }

            if isCached {
                strongSelf.imageView.image = image
            } else {
                UIView.transition(with: strongSelf, duration: 0.25, options: [.transitionCrossDissolve], animations: {
                    strongSelf.imageView.image = image
                }, completion: nil)
            }
        })
    }
}
