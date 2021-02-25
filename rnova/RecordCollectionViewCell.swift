//
//  RecordCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 2/24/21.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    
    
    let label = UILabel()
    let proileImageView = UIImageView()
    let profileImage = UIImage(systemName: "person")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.frame = CGRect(x: 80, y: 20, width: 250, height: 40)
        self.addSubview(label)
        
        proileImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        proileImageView.image = profileImage
        self.addSubview(proileImageView)
    }

    func setup(color: UIColor) {
        backgroundColor = color
    }
}
