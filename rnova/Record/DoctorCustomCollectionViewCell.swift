//
//  DoctorCustomCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/31/21.
//

import UIKit

class DoctorCustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "DoctorCustomCollectionViewCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = label.font.withSize(20)
        label.textColor = .black
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
