//
//  DataLoader.swift
//  rnova
//
//  Created by Александр Меренков on 2/1/21.
//

import Foundation

public class  DataLoader {

    @Published var userData = [Users]()
    
    
    
    
    init() {
        load()
    }
    
    func load() {
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
//        if let fileLocation = Bundle.main.url(forResource: "file", withExtension: "json") {
            
//        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
//            do {
//                let users = try JSONDecoder().decode([Users].self, from: data!)
//                self.userData = users
//            }
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Users].self, from: data)
                self.userData = dataFromJson
            }
            catch {
                print("There was an error finding in the data! ")
            }
        }
        
    }
   
}

struct Users: Decodable {
    let id: Int
    let title: String
    let body: String
}
