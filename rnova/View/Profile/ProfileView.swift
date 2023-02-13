//
//  ProfileView.swift
//  rnova
//
//  Created by Александр Меренков on 12/2/21.
//

import UIKit

final class ProfileView: UIView {
    
//    MARK: - Properties
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.backgroundColor = .lightGray
        return label
    }()
    
    private let lastnameTitleLabel = UILabel().profileTitleLabel("Фамилия")
    private let lastnameUserLabel = UILabel().profileLabel(size: 21)
    private let firstnameTitleLabel = UILabel().profileTitleLabel("Имя")
    private let firstnameUserLabel = UILabel().profileLabel()
    private let surnameTitleLabel = UILabel().profileTitleLabel("Отчество")
    private let surnameUserLabel = UILabel().profileLabel()
    private let dateTitleLabel = UILabel().profileTitleLabel("Дата рождения", size: 12)
    private let dateUserLabel = UILabel().profileLabel()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePhone()
        configureLastname()
        configureFirstname()
        configureSurname()
        configureDate()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configurePhone() {
        addSubview(phoneLabel)
        phoneLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, height: 60)
    }
    
    private func configureLastname() {
        addSubview(lastnameTitleLabel)
        addSubview(lastnameUserLabel)
        lastnameTitleLabel.anchor(left: leftAnchor, top: phoneLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 40, height: 15)
        lastnameUserLabel.anchor(left: leftAnchor, top: lastnameTitleLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, height: 30)
    }
    
    private func configureFirstname() {
        addSubview(firstnameTitleLabel)
        addSubview(firstnameUserLabel)
        firstnameTitleLabel.anchor(left: leftAnchor, top: lastnameUserLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 20, height: 15)
        firstnameUserLabel.anchor(left: leftAnchor, top: firstnameTitleLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, height: 30)
    }
    
    private func configureSurname() {
        addSubview(surnameTitleLabel)
        addSubview(surnameUserLabel)
        surnameTitleLabel.anchor(left: leftAnchor, top: firstnameUserLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 20, height: 15)
        surnameUserLabel.anchor(left: leftAnchor, top: surnameTitleLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, height: 30)
    }
    
    private func configureDate() {
        addSubview(dateTitleLabel)
        addSubview(dateUserLabel)
        dateTitleLabel.anchor(left: leftAnchor, top: surnameUserLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 20, height: 15)
        dateUserLabel.anchor(left: leftAnchor, top: dateTitleLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, height: 30)
    }
    
    func setInformation(_ user: User) {
        lastnameUserLabel.text = user.lastname
        firstnameUserLabel.text = user.firstname
        surnameUserLabel.text = user.surname
        dateUserLabel.text = user.date
        phoneLabel.text = "  " + user.phoneNumber
    }
}
