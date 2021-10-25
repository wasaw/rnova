//
//  RecordViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 10/13/21.
//

import UIKit

class RecordViewCell: UICollectionViewCell {
    static let identifite = "RecordViewCell"
    
    let surnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
  
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(surnameLabel)
        self.addSubview(professionLabel)
        self.addSubview(profileImageView)
        
        let stack = UIStackView(arrangedSubviews: [surnameLabel, professionLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        self.addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 30).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        shadow()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
