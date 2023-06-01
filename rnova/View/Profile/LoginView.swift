//
//  LoginView.swift
//  rnova
//
//  Created by Александр Меренков on 11/26/21.
//

import UIKit

private enum Constants {
    static let phoneNumberFieldHorizontalPaddings: CGFloat = 20
    static let phoneNumberFieldPaddingTop: CGFloat = 30
    static let phoneNumberFieldHeight: CGFloat = 40
    static let passwordFieldHorizontalPaddings: CGFloat = 20
    static let passwordFieldPaddingTop: CGFloat = 20
    static let passwordFieldHeight: CGFloat = 40
    static let enterButtonHorizontalPaddings: CGFloat = 10
    static let enterButtonPaddingTop: CGFloat = 30
    static let enterButtonHeight: CGFloat = 60
}

protocol SendLoginInformationProtocol: AnyObject {
    func sendLoginInformation(phoneNumber: String, password: String)
}

final class LoginView: UIView {
    
//    MARK: - Properties
    
    private lazy var phoneNumberField = UIView().fieldForForm(placeholder: "Номер телефона")
    private lazy var passwordField = UIView().fieldForForm(placeholder: "Пароль", isSecure: true)
    private lazy var enterButton = UIView().getButton()
    
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
        phoneNumberField.anchor(left: leftAnchor,
                                top: safeAreaLayoutGuide.topAnchor,
                                right: rightAnchor,
                                paddingLeft: Constants.phoneNumberFieldHorizontalPaddings,
                                paddingTop: Constants.phoneNumberFieldPaddingTop,
                                paddingRight: -Constants.phoneNumberFieldHorizontalPaddings,
                                height: Constants.phoneNumberFieldHeight)
        passwordField.anchor(left: leftAnchor,
                             top: phoneNumberField.bottomAnchor,
                             right: rightAnchor,
                             paddingLeft: Constants.passwordFieldHorizontalPaddings,
                             paddingTop: Constants.passwordFieldPaddingTop,
                             paddingRight: -Constants.passwordFieldHorizontalPaddings,
                             height: Constants.passwordFieldHeight)
        enterButton.anchor(left: leftAnchor,
                           top: passwordField.bottomAnchor,
                           right: rightAnchor,
                           paddingLeft: Constants.enterButtonHorizontalPaddings,
                           paddingTop: Constants.enterButtonPaddingTop,
                           paddingRight: -Constants.enterButtonHorizontalPaddings,
                           height: Constants.enterButtonHeight)
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
