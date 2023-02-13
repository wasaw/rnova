//
//  NetworkConfiguration.swift
//  rnova
//
//  Created by Александр Меренков on 10.02.2023.
//

import Foundation

struct NetworkConfiguration {
    
//    MARK: - Properties
    
    private let apiUrl = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on"
    
//    MARK: - Helpers
    
    func getUrl() -> String {
        return apiUrl
    }
}
