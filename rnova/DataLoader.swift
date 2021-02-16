//
//  DataLoader.swift
//  rnova
//
//  Created by Александр Меренков on 2/1/21.
//

import Foundation
import Alamofire

public class  DataLoader {
    
    
  
//    @Published var userData = [Users]()
    @Published var doctorsData = [Doctors]()
    
    
    
    init() {
        load()
    }
    
    func load() {
        let urlSourse = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on&method=getServiceCategories"
        if let url = URL(string: urlSourse) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Doctors].self, from: data)
                self.doctorsData = dataFromJson
            }
            catch {
                print("There was an error finding in the data! ")
            }
        }
                
    }
   
}


struct Doctors: Decodable {
    let id: Int
    let title: String
    let services_count: Int
//    let children: String
}
