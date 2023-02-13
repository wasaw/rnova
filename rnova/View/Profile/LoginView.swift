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

final class LoginView: UIView {
    
//    MARK: - Properties
    
    private let phoneNumberField = UIView().fieldForForm(placeholder: "Номер телефона")
    private let passwordField = UIView().fieldForForm(placeholder: "Пароль", isSecure: true)
    private let enterButton = UIView().getButton()
    
    weak var delegate: SendLoginInformationProtocol?

//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        enterButton.addTarget(self, action: #selector(entering), for: .touchUpInside)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(phoneNumberField)
        addSubview(passwordField)
        addSubview(enterButton)
        phoneNumberField.anchor(left: leftAnchor, top: safeAreaLayoutGuide.topAnchor, right: rightAnchor, paddingLeft: 20, paddingTop: 30, paddingRight: -20, height: 40)
        passwordField.anchor(left: leftAnchor, top: phoneNumberField.bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingTop: 20, paddingRight: -20, height: 40)
        enterButton.anchor(left: leftAnchor, top: passwordField.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 30, paddingRight: -10, height: 60)
        enterButton.backgroundColor = UIColor.systemOrange
        enterButton.setTitle("Войти", for: .normal)
    }
    
//    MARK: - Helpers
    
    @objc private func entering() {
        guard let phoneNumber = phoneNumberField.text else { return }
        guard let password = passwordField.text else { return }
        delegate?.sendLoginInformation(phoneNumber: phoneNumber, password: password)
    }
    
}
