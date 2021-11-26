//
//  RegistrationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/23/21.
//

import UIKit

protocol SendValueProtocol {
    func recordUser(user: User)
}

protocol PresentViewProtocol {
    func showNewView()
}

class RegistrationView: UIView {
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
    private let dateField: UITextField = {
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
    
    private let datePicker = UIDatePicker()
    
    private let registrationButton = View().button
    private let enterButton = View().button
    
    var delegate: SendValueProtocol?
    var delegateShow: PresentViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lastNameField)
        addSubview(firstNameField)
        addSubview(surnameField)
        addSubview(dateField)
        addSubview(phoneNumberField)
        addSubview(registrationButton)
        addSubview(enterButton)
        
        configureView()
        configureDatePicker()

        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        configureRegistrationButton()
        configureEnterButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        lastNameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        lastNameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        lastNameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        lastNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lastNameField.addLine()
        
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        firstNameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        firstNameField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 10).isActive = true
        firstNameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        firstNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        firstNameField.addLine()
        
        surnameField.translatesAutoresizingMaskIntoConstraints = false
        surnameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        surnameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10).isActive = true
        surnameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        surnameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        surnameField.addLine()
        
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        dateField.topAnchor.constraint(equalTo: surnameField.bottomAnchor, constant: 10).isActive = true
        dateField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        dateField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateField.addLine()
        
        phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        phoneNumberField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 10).isActive = true
        phoneNumberField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        phoneNumberField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        phoneNumberField.addLine()
    }
    
    func configureRegistrationButton() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        registrationButton.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 30).isActive = true
        registrationButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        registrationButton.backgroundColor = UIColor.systemGreen
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.addTarget(self, action: #selector(registering), for: .touchUpInside)
    }
    
    func configureEnterButton() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        enterButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 20).isActive = true
        enterButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        enterButton.backgroundColor = UIColor.systemOrange
        enterButton.setTitle("Войти", for: .normal)
        enterButton.addTarget(self, action: #selector(entering), for: .touchUpInside)
    }
    
    func configureDatePicker() {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelAction))
    }
    
    @objc func registering() {
        guard let lastName = lastNameField.text, let firstName = firstNameField.text, let surName = surnameField.text, let date = dateField.text, let phoneNumber = phoneNumberField.text else { return }
        
        let user = User(lastname: lastName, firstname: firstName, surname: surName, date: date, phoneNumber: phoneNumber)
        delegate?.recordUser(user: user)
    }
    
    @objc func entering() {
        delegateShow?.showNewView()
    }
    
    @objc func doneAction() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc func cancelAction() {
        dateField.text = "Дата рождения"
        endEditing(true)
    }
}
