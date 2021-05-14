//
//  ConnectionSession.swift
//  PhotoGallery
//
//  Created by C, Prasanth on 14/05/21.
//

import Foundation

open class ConnectionSession {
    
    public static let shared: ConnectionSession = {
        let instance = ConnectionSession()
        // additional setup if needed
        return instance
    }()

    private lazy var session_: URLSession = {
        let instance = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        // additional setup if needed
        return instance
    }()
    
    /// Override to return the type of session your application needs
    open var session: URLSession {
        get {
            return session_
        }
    }
    
    func send(request: ConnectionRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        runSessionDataTask(request: request.request, completion: completion)
    }
    
    private func runSessionDataTask(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: request) { (data, response, error) in

            /* Important!!!
               for convenience push this back on the main thread */

            DispatchQueue.main.async {
                #if DEBUG
                
                print(
                    """
                    request: \(request),
                    data: \(String(describing: data)),
                    response: \(String(describing: response)),
                    error: \(String(describing: error))
                    """
                )
                
                #endif
                
                completion(data, response, error)
            }
        }
        
        task.resume()
        
    }
}
