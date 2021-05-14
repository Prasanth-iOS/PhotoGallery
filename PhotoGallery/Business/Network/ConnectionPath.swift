//
//  ConnectionPath.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

public struct ConnectionPath {
    let absolutePath: String
    
    public init(absolutePath: String) {
        self.absolutePath = absolutePath
    }
}

public extension ConnectionPath {
    static func path(domain: String, service: String? = nil, paramaters: [String: String]? = nil) -> ConnectionPath {
        
        var path = domain
        if let service = service {
            path += "/\(service)"
        }

        if let params = paramaters {
            path += urlParameterEncode(dictionary: params)
        }
        
        return .init(absolutePath: path)
    }

    static func urlParameterEncode(dictionary: [String : String], percentEncoded: Bool = true, omittingQueryComponent: Bool = false) -> String {
        let characterSet = CharacterSet.alphanumerics
        let queryComponent = omittingQueryComponent ? "" : "?"
        return dictionary.enumerated().reduce(queryComponent, { (result, pair) -> String in
            guard let key = percentEncoded ? pair.element.key.addingPercentEncoding(withAllowedCharacters: characterSet) : pair.element.key else { return result }
            guard let value = percentEncoded ? pair.element.value.addingPercentEncoding(withAllowedCharacters: characterSet) : pair.element.value else { return result }
            return pair.offset == 0 ? "\(result)\(key)=\(value)" : "\(result)&\(key)=\(value)"
        })
    }
}

extension ConnectionPath {
    static func getAlbumServicePath(with parameters: [String: String]?) -> ConnectionPath {
        return getServicePath(endPoint: .albums, parameters: parameters)
    }

    static func getPhotoServicePath(with parameters: [String: String]?) -> ConnectionPath {
        return getServicePath(endPoint: .photos, parameters: parameters)
    }

    static func getServicePath(endPoint: EndPoint,
                               parameters: [String: String]? = nil) -> ConnectionPath {
        return ConnectionPath.path(domain: Configuration.shared.apiURL,
                                   service: endPoint.rawValue,
                                   paramaters: parameters)

    }
}

enum EndPoint: String {
    case albums = "albums"
    case photos = "photos"
}
