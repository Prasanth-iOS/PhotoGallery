//
//  ConnectionTask.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

public enum ConnectionMethod: String {
    case get = "GET"
    // add other methods if needed
}

struct ConnectionRequest {
    var request: URLRequest
}

public struct ConnectionTask {
    
    var request: ConnectionRequest
    let session: ConnectionSession

     var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    @discardableResult
    public init(path: ConnectionPath, session: ConnectionSession = ConnectionSession.shared) throws {
        self.session = session
        guard let url = URL(string: path.absolutePath) else {
            throw ConnectionError.nilUrl(attemptedPath: path.absolutePath)
        }
        request = ConnectionRequest(request: URLRequest(url: url))
    }
    
    @discardableResult
    public func method(_ method: ConnectionMethod) -> ConnectionTask {
        var copy = self
        copy.request.request.httpMethod = method.rawValue
        return copy
    }
    
    public func send(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.send(request: request, completion: completion)
    }

    /// - Parameter completion: values pass correspond to the state of success for the method call
    public func send<T: Codable>(completion: @escaping (T?, URLResponse?, Error?) -> Void) {
        send(completion: completionHandler(completion))
    }

    func send<T: Codable>(completion: @escaping (Result<T, ConnectionError>) -> Void) {
        send(completion: { (data: T?, response, error) in
            if let responseData = data {
                completion(.success(responseData))
            } else {
                completion(.failure(error as? ConnectionError ?? .unknown))
            }
        })
    }

    private func completionHandler<T: Codable>(_ completion: @escaping (T?, URLResponse?, Error?) -> Void) -> (Data?, URLResponse?, Error?) -> Void {
        return { (data_, response, err) in
            guard let data = data_ else { completion(nil, response, err); return }
            
            do {
                let value = try self.jsonDecoder.decode(T.self, from: data)
                completion(value, response, err)
                
            } catch {
                let err = ConnectionError.failedJSONDecoding(error, data)
                completion(nil, response, err)
            }
        }
    }
}


public enum ConnectionError: Error {
    case nilUrl(attemptedPath: String)
    case failedJSONDecoding(Error, Data)
    case unknown
}
