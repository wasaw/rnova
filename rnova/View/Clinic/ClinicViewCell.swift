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
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel, emailLabel, phoneLabel, button])
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 6
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        backgroundColor = .white
        
    }
}
