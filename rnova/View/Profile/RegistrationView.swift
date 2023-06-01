//
//  RegistrationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/23/21.
//

import UIKit

private enum Constants {
    static let stackHorizontalPaddings: CGFloat = 20
    static let stackPaddingTop: CGFloat = 30
    static let stackHeight: CGFloat = 300
    static let registrationButtonHorizontalPaddings: CGFloat = 10
    static let registrationButtonPaddingTop: CGFloat = 30
    static let registrationButtonHeight: CGFloat = 60
    static let enterButtonHorizontalPadding: CGFloat = 10
    static let enterButtonPaddingTop: CGFloat = 20
    static let enterButtonHeight: CGFloat = 60
}

protocol SendValueProtocol: AnyObject {
    func recordUser(user: User)
}

protocol PresentViewProtocol: AnyObject {
    func showNewView()
}

final class RegistrationView: UIView {
    
//    MARK: - Properties
    
    private lazy var lastNameField = UIView().fieldForForm(placeholder: "Фамилия")
    private lazy var firstNameField = UIView().fieldForForm(placeholder: "Имя")
    private lazy var surnameField = UIView().fieldForForm(placeholder: "Отчество")
    private lazy var dateField = UIView().fieldForForm(placeholder: "Дата рождения")
    private lazy var phoneNumberField = UIView().fieldForForm(placeholder: "Номер телефона")
    private lazy var passwordField = UIView().fieldForForm(placeholder: "Пароль", isSecure: true)
    
    private let datePicker = UIDatePicker()
    
    private lazy var registrationButton = UIView().getButton()
    private lazy var enterButton = UIView().getButton()
    
    weak var delegate: SendValueProtocol?
    weak var delegateShow: PresentViewProtocol?

//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureDatePicker()

        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - Helpers
    
    private func configureUI() {
        let stack = UIStackView(arrangedSubviews: [lastNameField,
                                                   firstNameField,
                                                   surnameField,
                                                   dateField,
                                                   phoneNumberField,
                                                   passwordField])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.anchor(left: leftAnchor,
                     top: topAnchor,
                     right: rightAnchor,
                     paddingLeft: Constants.stackHorizontalPaddings,
                     paddingTop: Constants.stackPaddingTop,
                     paddingRight: -Constants.stackHorizontalPaddings,
                     height: Constants.stackHeight)
        
        addSubview(registrationButton)
        registrationButton.anchor(left: leftAnchor,
                                  top: stack.bottomAnchor,
                                  right: rightAnchor,
                                  paddingLeft: Constants.registrationButtonHorizontalPaddings,
                                  paddingTop: Constants.registrationButtonPaddingTop,
                                  paddingRight: -Constants.registrationButtonHorizontalPaddings,
                                  height: Constants.registrationButtonHeight)
        registrationButton.backgroundColor = UIColor.systemGreen
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.addTarget(self, action: #selector(registering), for: .touchUpInside)
        
        addSubview(enterButton)
        enterButton.anchor(left: leftAnchor,
                           top: registrationButton.bottomAnchor,
                           right: rightAnchor,
                           paddingLeft: Constants.enterButtonHorizontalPadding,
                           paddingTop: Constants.enterButtonPaddingTop,
                           paddingRight: -Constants.enterButtonHorizontalPadding,
                           height: Constants.enterButtonHeight)
        enterButton.backgroundColor = UIColor.systemOrange
        enterButton.setTitle("Войти", for: .normal)
        enterButton.addTarget(self, action: #selector(entering), for: .touchUpInside)
    }
    
    private func configureDatePicker() {
        dateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        dateField.inputAccessoryView = toolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
        _ = UITapGestureRecognizer(target: self, action: #selector(cancelAction))
    }
    
//    MARK: - Selecters
    
    @objc private func registering() {
        guard let lastName = lastNameField.text, let firstName = firstNameField.text, let surName = surnameField.text, let date = dateField.text, let phoneNumber = phoneNumberField.text, let password = passwordField.text else { return }
        
        let user = User(lastname: lastName, firstname: firstName, surname: surName, date: date, phoneNumber: phoneNumber, password: password)
        delegate?.recordUser(user: user)
    }
    
    @objc private func entering() {
        delegateShow?.showNewView()
    }
    
    @objc private func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc private func cancelAction() {
        dateField.text = "Дата рождения"
        endEditing(true)
    }
}
