//
//  LoginView.swift
//  rnova
//
//  Created by Александр Меренков on 11/26/21.
//

import UIKit

protocol SendLoginInformationProtocol: AnyObject {
    func sendLoginInformation(phoneNumber: String, password: String)
}

class LoginView: UIView {
    private let phoneNumberField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Номер телефона"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.returnKeyType = .done
        return tf
    }()
    
    private let enterButton = View().button
    
    weak var delegate: SendLoginInformationProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(phoneNumberField)
        addSubview(passwordField)
        addSubview(enterButton)
        
        enterButton.backgroundColor = UIColor.systemOrange
        enterButton.setTitle("Войти", for: .normal)
        enterButton.addTarget(self, action: #selector(entering), for: .touchUpInside)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        phoneNumberField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        phoneNumberField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneNumberField.addLine()
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        passwordField.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 20).isActive = true
        passwordField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.addLine()
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        enterButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        enterButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func entering() {
        guard let phoneNumber = phoneNumberField.text else { return }
        guard let password = passwordField.text else { return }
        delegate?.sendLoginInformation(phoneNumber: phoneNumber, password: password)
    }
    
}
