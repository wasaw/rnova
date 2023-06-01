//
//  DoctorInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

private enum Constant {
    static let profileImageViewPaddingLeft: CGFloat = 20
    static let profileImageViewDimensions: CGFloat = 60
    static let stackPaddingLeft: CGFloat = 30
    static let stackPadding: CGFloat = 10
}

final class DoctorInformationView: UIView {
    
//    MARK: - Properties
    
    private lazy var surnameLabel: UILabel = {
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
//    MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.anchor(left: leftAnchor,
                                paddingLeft: Constant.profileImageViewPaddingLeft,
                                width: Constant.profileImageViewDimensions,
                                height: Constant.profileImageViewDimensions)
        
        let stack = UIStackView(arrangedSubviews: [surnameLabel, professionLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        addSubview(stack)
        stack.anchor(left: profileImageView.rightAnchor,
                     top: topAnchor,
                     right: rightAnchor,
                     bottom: bottomAnchor,
                     paddingLeft: Constant.stackPaddingLeft,
                     paddingTop: Constant.stackPadding,
                     paddingRight: -Constant.stackPadding,
                     paddingBottom: -Constant.stackPadding)
    }
    
    private func shadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func setInformation(_ doctor: Doctor) {
        surnameLabel.text = doctor.name
        professionLabel.text = doctor.profession_titles
        profileImageView.image = doctor.image.image
    }
}
