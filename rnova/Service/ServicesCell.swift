//
//  ServicesCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/24/21.
//

import UIKit

class ServicesCell: UICollectionViewCell {

    let label = UILabel()
    let imageView = UIImageView()
    let image = UIImage(systemName: "chevron.right")
    
    override func awakeFromNib() {
        super.awakeFromNib()

        label.frame = CGRect(x: 20, y: 12, width: 300, height: 40)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        self.addSubview(label)

        shadow()
        backgroundColor = .white
    }

}
