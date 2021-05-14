//
//  Photo.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

public struct Photo: Codable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
}
