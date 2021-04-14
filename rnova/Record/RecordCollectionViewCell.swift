//
//  RecordCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 2/24/21.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    
    
    let label = UILabel()
    let profileImageView = UIImageView()
    let profileImage = UIImage(systemName: "person")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        label.frame = CGRect(x: 80, y: 20, width: 280, height: 40)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        self.addSubview(label)
        
        profileImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        profileImageView.image = profileImage
        self.addSubview(profileImageView)
    }

    func setup(color: UIColor) {
        backgroundColor = color
    }
}
