//
//  JsonDecoder.swift
//  rnova
//
//  Created by Александр Меренков on 10.02.2023.
//

import Foundation

struct JsonHelpers {
    static let shared = JsonHelpers()
    
//    MARK: - Properties
    
    private let jsonDecoder = JSONDecoder()
    
//    MARK: - Helpers
    
    func decode<T: Decodable>(data: Data, _ type: T.Type) -> T? {
        return try? jsonDecoder.decode(type, from: data)
    }
}
