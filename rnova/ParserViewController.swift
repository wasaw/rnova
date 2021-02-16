//
//  ParserViewController.swift
//  rnova
//
//  Created by Александр Меренков on 2/15/21.
//

import UIKit
import Alamofire

class ParserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let urlSourse = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on&method=getUsers"
            var doctorData = [DoctorsArr]()
            if let url = URL(string: urlSourse) {
                do {
                    let data = try Data(contentsOf: url)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([DoctorsArr].self, from: data)
                    doctorData = dataFromJson
                    print(doctorData[0].id)
                }
                catch {
                    print("There was an error finding in the data! ")
                }
            }
        
        
    }
}

struct DoctorsArr: Codable {
    let id: Int
    let name: String
}
