//
//  RecordCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 2/24/21.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    var profileImageView = UIImageView()
    let profileImage = UIImage(systemName: "person")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        self.addSubview(label)
        
        profileImageView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 25
        profileImageView.layer.masksToBounds = false
        profileImageView.clipsToBounds = true
        profileImageView.image = profileImage
        self.addSubview(profileImageView)

        shadow()
        backgroundColor = .white
    }
}
