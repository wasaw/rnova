//
//  RecordViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 10/13/21.
//

import UIKit

private enum Constants {
    static let profileImageViewpaddingLeading: CGFloat = 20
    static let profileImageViewDimensions: CGFloat = 60
    static let stackpaddingLeading: CGFloat = 30
    static let stackPadding: CGFloat = 10
}

final class DoctorViewCell: UICollectionViewCell {
    static let identifire = "DoctorViewCell"

//    MARK: - Properties
    
    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private lazy var professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
  
    private lazy var profileImageView: UIImageView = {
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
        profileImageView.anchor(leading: leadingAnchor,
                                paddingLeading: Constants.profileImageViewpaddingLeading,
                                width: Constants.profileImageViewDimensions,
                                height: Constants.profileImageViewDimensions)
        
        stack.anchor(leading: profileImageView.rightAnchor,
                     top: topAnchor,
                     trailing: trailingAnchor,
                     bottom: bottomAnchor,
                     paddingLeading: Constants.stackpaddingLeading,
                     paddingTop: Constants.stackPadding,
                     paddingTrailing: -Constants.stackPadding,
                     paddingBottom: -Constants.stackPadding)
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
