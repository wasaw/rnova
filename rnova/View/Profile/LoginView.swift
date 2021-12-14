//
//  LoginView.swift
//  rnova
//
//  Created by Александр Меренков on 11/26/21.
//

import UIKit

protocol SendPhoneNumberProtocol: AnyObject {
    func sendProtocol(phoneNumber: String)
}

class LoginView: UIView {
    private let phoneNumberField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Номер телефона"
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        return tf
    }()
    
    private let enterButton = View().button
    
    weak var delegate: SendPhoneNumberProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(phoneNumberField)
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
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        enterButton.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 30).isActive = true
        enterButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func entering() {
        guard let phoneNumber = phoneNumberField.text else { return }
        delegate?.sendProtocol(phoneNumber: phoneNumber)
    }
    
}
