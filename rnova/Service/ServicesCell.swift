//
//  ServicesCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/24/21.
//

import UIKit

class ServicesCell: UICollectionViewCell {

    let label = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.frame = CGRect(x: 20, y: 20, width: 300, height: 40)
        label.font = label.font.withSize(20)
        label.textColor = .black
        self.addSubview(label)
        backgroundColor = .white
    }

}
