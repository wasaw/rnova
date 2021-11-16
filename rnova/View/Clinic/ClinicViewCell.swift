//
//  ClinicViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/16/21.
//

import UIKit

class ClinicViewCell: UICollectionViewCell {
    static let identifire = "ClinicViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemOrange
        label.isUserInteractionEnabled = true
        return label
    }()
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Позвонить", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setImage(UIImage(systemName: "phone"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .lightGray
        return btn
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(emailLabel)
        addSubview(phoneLabel)
        addSubview(button)
        
        shadow()
        backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        emailLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        button.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }

}
