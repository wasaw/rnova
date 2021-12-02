//
//  ProfileView.swift
//  rnova
//
//  Created by Александр Меренков on 12/2/21.
//

import UIKit

class ProfileView: UIView {
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.backgroundColor = .lightGray
        return label
    }()
    private let lastnameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.text = "Фамилия"
        return label
    }()
    let lastnameUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()
    private let firstnameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Имя"
        return label
    }()
    let firstnameUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    private let surnameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Отчество"
        return label
    }()
    let surnameUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Дата рождения"
        return label
    }()
    let dateUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(phoneLabel)
        addSubview(lastnameTitleLabel)
        addSubview(lastnameUserLabel)
        addSubview(firstnameTitleLabel)
        addSubview(firstnameUserLabel)
        addSubview(surnameTitleLabel)
        addSubview(surnameUserLabel)
        addSubview(dateTitleLabel)
        addSubview(dateUserLabel)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        configureLastname()
        configureFirstname()
        configureSurname()
        configureDate()
    }
    
    func configureLastname() {
        lastnameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lastnameTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        lastnameTitleLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 40).isActive = true
        lastnameTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        lastnameTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        lastnameUserLabel.translatesAutoresizingMaskIntoConstraints = false
        lastnameUserLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        lastnameUserLabel.topAnchor.constraint(equalTo: lastnameTitleLabel.bottomAnchor, constant: 5).isActive = true
        lastnameUserLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        lastnameUserLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lastnameUserLabel.addLine()
    }
    
    func configureFirstname() {
        firstnameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstnameTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        firstnameTitleLabel.topAnchor.constraint(equalTo: lastnameUserLabel.bottomAnchor, constant: 20).isActive = true
        firstnameTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        firstnameTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        firstnameUserLabel.translatesAutoresizingMaskIntoConstraints = false
        firstnameUserLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        firstnameUserLabel.topAnchor.constraint(equalTo: firstnameTitleLabel.bottomAnchor, constant: 5).isActive = true
        firstnameUserLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        firstnameUserLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        firstnameUserLabel.addLine()
    }
    
    func configureSurname() {
        surnameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        surnameTitleLabel.topAnchor.constraint(equalTo: firstnameUserLabel.bottomAnchor, constant: 20).isActive = true
        surnameTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        surnameTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        surnameUserLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameUserLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        surnameUserLabel.topAnchor.constraint(equalTo: surnameTitleLabel.bottomAnchor, constant: 5).isActive = true
        surnameUserLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        surnameUserLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        surnameUserLabel.addLine()
    }
    
    func configureDate() {
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateTitleLabel.topAnchor.constraint(equalTo: surnameUserLabel.bottomAnchor, constant: 20).isActive = true
        dateTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dateTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        dateUserLabel.translatesAutoresizingMaskIntoConstraints = false
        dateUserLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateUserLabel.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: 5).isActive = true
        dateUserLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dateUserLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateUserLabel.addLine()
    }
}
