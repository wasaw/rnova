//
//  RecordViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 10/13/21.
//

import UIKit

class DoctorViewCell: UICollectionViewCell {
    static let identifire = "DoctorViewCell"

//    MARK: - Properties
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
  
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(fullnameLabel)
        self.addSubview(professionLabel)
        self.addSubview(profileImageView)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, professionLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        addSubview(stack)
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.anchor(left: leftAnchor, paddingLeft: 20, width: 60, height: 60)
        
        stack.anchor(left: profileImageView.rightAnchor, top: topAnchor, right: rightAnchor, bottom: bottomAnchor, paddingLeft: 30, paddingTop: 10, paddingRight: -10, paddingBottom: -10)
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    func setInformation(_ doctor: Doctor) {
        fullnameLabel.text = doctor.name
        professionLabel.text = doctor.profession_titles
        profileImageView.image = doctor.image.image
    }
}
