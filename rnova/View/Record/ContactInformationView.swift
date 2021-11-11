//
//  ContactInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

class ContactInformationView: UIView {
    
    private let lastNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Фамилия"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    private let firstNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Имя"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    private let surnameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Отчество"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    let dateField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Дата рождения"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    private let phoneNumberField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Номер телефона"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    private let commentField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Комментарий"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lastNameField)
        addSubview(firstNameField)
        addSubview(surnameField)
        addSubview(dateField)
        addSubview(phoneNumberField)
        addSubview(commentField)
        
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        lastNameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        lastNameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lastNameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        lastNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lastNameField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(lastNameField)
        
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        firstNameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        firstNameField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 10).isActive = true
        firstNameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        firstNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstNameField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(firstNameField)
        
        surnameField.translatesAutoresizingMaskIntoConstraints = false
        surnameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        surnameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10).isActive = true
        surnameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        surnameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        surnameField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(surnameField)
        
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateField.topAnchor.constraint(equalTo: surnameField.bottomAnchor, constant: 10).isActive = true
        dateField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dateField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(dateField)
        
        phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        phoneNumberField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 10).isActive = true
        phoneNumberField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneNumberField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(phoneNumberField)
        
        commentField.translatesAutoresizingMaskIntoConstraints = false
        commentField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        commentField.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 10).isActive = true
        commentField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        commentField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        commentField.widthAnchor.constraint(equalToConstant: self.bounds.width - 20).isActive = true
        line(commentField)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func line(_ textField: UITextField) {
        let line = UIView()
        self.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        line.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.backgroundColor = .lightGray
    }
}
