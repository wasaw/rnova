//
//  ContactInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

final class ContactInformationView: UIView {
    
//    MARK: - Properties
    
    let lastNameField = UIView().fieldForForm(placeholder: "Фамилия")
    let firstNameField = UIView().fieldForForm(placeholder: "Имя")
    let surnameField = UIView().fieldForForm(placeholder: "Отчество")
    let dateField = UIView().fieldForForm(placeholder: "Дата рождения")
    let phoneNumberField = UIView().fieldForForm(placeholder: "Номер телефона")
    let commentField = UIView().fieldForForm(placeholder: "Комментарий")
    
//    MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [lastNameField, firstNameField, surnameField, dateField, phoneNumberField, phoneNumberField, commentField])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, bottom: bottomAnchor, paddingLeft: 10, paddingTop: 15, paddingRight: -10, paddingBottom: -15)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension ContactInformationView: SendCommentProtocol {
    func gettingComment() -> String? {
        return commentField.text
    }
}

