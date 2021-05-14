//
//  PhotoGalleryConfiguration.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

public struct PhotoGalleryConfiguration {

    /// The memory capacity used by the cache.
    public var memoryCapacity = defaultMemoryCapacity

    /// The disk capacity used by the cache.
    public var diskCapacity = defaultDiskCapacity

    /// The default memory capacity used by the cache.
    public static let defaultMemoryCapacity: Int = ImageCache.memoryCapacity

    /// The default disk capacity used by the cache.
    public static let defaultDiskCapacity: Int = ImageCache.diskCapacity

    /// The base API url.
    let apiURL = "https://jsonplaceholder.typicode.com"

    public init(memoryCapacity: Int = defaultMemoryCapacity,
                diskCapacity: Int = defaultDiskCapacity) {
        self.memoryCapacity = memoryCapacity
        self.diskCapacity = diskCapacity
    }

    init() {}

}
