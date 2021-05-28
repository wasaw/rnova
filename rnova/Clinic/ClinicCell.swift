//
//  ClinicCell.swift
//  rnova
//
//  Created by Александр Меренков on 4/8/21.
//

import UIKit

class ClinicCell: UICollectionViewCell {

    let titleLabel = UILabel()
    let addressLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let button = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.frame = CGRect(x: 15, y: 15, width: 300, height: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        self.addSubview(titleLabel)
        
        addressLabel.frame = CGRect(x: 15, y: 45, width: 350, height: 50)
        addressLabel.textColor = .gray
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.numberOfLines = 2
        self.addSubview(addressLabel)
        
        emailLabel.frame = CGRect(x: 15, y: 95, width: 350, height: 20)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .systemOrange
        self.addSubview(emailLabel)
        
        phoneLabel.frame = CGRect(x: 15, y: 115, width: 350, height: 20)
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        self.addSubview(phoneLabel)
        
        button.frame = CGRect(x: 15, y: 145, width: 120, height: 30)
        button.setTitle(" Позвонить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .lightGray
        self.addSubview(button)

        shadow()
        backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        line(y: 40)
    }

}
