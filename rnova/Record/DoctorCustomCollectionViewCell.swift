//
//  DoctorCustomCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/31/21.
//

import UIKit

class DoctorCustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "DoctorCustomCollectionViewCell"
    
    let titleLable = UILabel()
    let addressLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLable.font = titleLable.font.withSize(20)
        titleLable.textColor = .black
        contentView.addSubview(titleLable)
        
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        addressLabel.numberOfLines = 2
        contentView.addSubview(addressLabel)
        
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .systemOrange
        contentView.addSubview(emailLabel)
        
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        contentView.addSubview(phoneLabel)
        
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
        let width = contentView.frame.width - 20
        titleLable.frame = CGRect(x: 15, y: 15, width: width, height: 30)
        addressLabel.frame = CGRect(x: 15, y: 45, width: width, height: 50)
        emailLabel.frame = CGRect(x: 15, y: 95, width: width, height: 20)
        phoneLabel.frame = CGRect(x: 15, y: 115, width: width, height: 20)
    }
}
