//
//  CustomCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/30/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
   
    let label = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
//        label.frame = CGRect(x: 20, y: 20, width: 300, height: 40)
        label.font = label.font.withSize(20 )
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 1.0
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20, y: contentView.frame.size.height - 60, width: contentView.frame.size.width - 20, height: 30)
    }
}
