//
//  Doctor.swift
//  rnova
//
//  Created by Александр Меренков on 2/3/22.
//

import Foundation
import UIKit

struct Doctor {
    let id: Int
    let name: String
    let profession: [String]
    let profession_titles: String
    let image: UIImageView
    
    init(id: Int, name: String, profession: [String], profession_titles: String, image: UIImageView) {
        self.id = id
        self.name = name
        self.profession = profession
        self.profession_titles = profession_titles
        self.image = image
    }
}
