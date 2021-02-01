//
//  Parser.swift
//  rnova
//
//  Created by Александр Меренков on 1/26/21.
//

import Foundation
 
//func  parse(pathForFile: String) -> [String] {
////    let data = try! Data(contentsOf: URL(fileURLWithPath: pathForFile))
//    
////    let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
//    var titleArray: [String]
//    titleArray = []
//    if let url = URL(string: pathForFile) {
//        
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            
//            do {
//                let users = try JSONDecoder().decode([Users].self, from: data!)
//                for user in users {
//                    titleArray.append(user.title)
//                }
//            }
//            catch {
//                print("There was an error finding in the data! ")
//            }
//        }.resume()
//    }
//    
//    return titleArray
//}
//
//struct Users: Decodable {
//    let id: Int
//    let title: String
//    let body: String
//}

