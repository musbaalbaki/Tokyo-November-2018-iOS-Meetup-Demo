//
//  URLFactory.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation

let baseURL = URLsConfig.shared.baseURL

struct URLFactory {
    static func getURL(path: String, parameters: [String: String] = [:]) -> URL? {
        return baseURL?.appendingPathComponent(path).appendingQueryParameters(parameters)
    }
}

extension URL {
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = []
        for (key, value) in parameters {
            urlComponents?.queryItems?.append(URLQueryItem(name:key, value: value as? String))
        }
        return urlComponents?.url
    }
}

struct URLsConfig {
    
    static let shared = URLsConfig()
    fileprivate let urls: NSDictionary
    
    // MARK: - Init
    
    fileprivate init() {
        let path = Bundle.main.path(forResource: "URLs", ofType: "plist")
        self.urls = NSDictionary(contentsOfFile: path!)!
    }
    
    // MARK: - Private methods
    
    private func URLFromConfiguration(key: String) -> URL? {
        return URL(string: objectFromConfiguration(key: key)!)
    }
    
    private func objectFromConfiguration(key: String) -> String? {
        let object = urls[key] as? String
        return object
    }
    
    // MARK: - Public read only properties
    
    var baseURL: URL! {
        return URLFromConfiguration(key: "BaseAPIURL")!
    }
}
