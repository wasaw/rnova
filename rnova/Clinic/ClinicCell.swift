//
//  ClinicCell.swift
//  rnova
//
//  Created by Александр Меренков on 4/8/21.
//

import UIKit

class ClinicCell: UICollectionViewCell {

    let titleLabel = UILabel()
    let adressLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let button = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
        titleLabel.frame = CGRect(x: 15, y: 15, width: 300, height: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        self.addSubview(titleLabel)
        
        adressLabel.frame = CGRect(x: 15, y: 45, width: 350, height: 50)
        adressLabel.textColor = .gray
        adressLabel.font = UIFont.systemFont(ofSize: 14)
        adressLabel.numberOfLines = 2
        self.addSubview(adressLabel)
        
        emailLabel.frame = CGRect(x: 15, y: 95, width: 350, height: 20)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .systemOrange
        self.addSubview(emailLabel)
//        let firstTap = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
//        emailLabel.isUserInteractionEnabled = true
//        emailLabel.addGestureRecognizer(firstTap)
        
        phoneLabel.frame = CGRect(x: 15, y: 115, width: 350, height: 20)
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        self.addSubview(phoneLabel)
        
        button.frame = CGRect(x: 15, y: 145, width: 140, height: 30)
        button.setTitle("   Позвонить", for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.setImage(UIImage(systemName: "phone"), for: .normal)
//        firstButton.contentHorizontalAlignment = .right
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemYellow
        self.addSubview(button)
//        button.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        
        backgroundColor = UIColor.white
        
    }

}
