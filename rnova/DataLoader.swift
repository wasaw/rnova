//
//  DataLoader.swift
//  rnova
//
//  Created by Александр Меренков on 2/1/21.
//

import Foundation
//import Alamofire

public class  DataLoader {
    
    @Published var servicesData = [Services]()
    
    init(urlParameter: String) {
        self.urlParameter = urlParameter
        load()
    }
    
    private let urlSourse = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on"
    private let urlMethod = "&method=getServiceCategories"
    private var urlParameter: String
    
    func load() {
//        let urlFull = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on&method=getServiceCategories&category_id=14264"
        let urlFull = urlSourse + urlMethod + urlParameter
        if let url = URL(string: urlFull) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Services].self, from: data)
                self.servicesData = dataFromJson
//                print(dataFromJson)
//                for item in servicesData {
//                    print("Title: \(item.title), count: \(item.services_count)")
//                }
            }
            catch {
                print("There was an error finding in the data! ")
            }
        }
                
    }
    
}

struct Services: Decodable {
    let id: Int
    let title: String
    let services_count: Int
//    let children: [Float]
}
