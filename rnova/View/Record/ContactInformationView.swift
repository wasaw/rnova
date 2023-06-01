//
//  ContactInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

private enum Constants {
    static let stackHorizontalPaddings: CGFloat = 10
    static let stackVerticalPaddings: CGFloat = 15
}

final class ContactInformationView: UIView {
    
//    MARK: - Properties
    
    lazy var lastNameField = UIView().fieldForForm(placeholder: "Фамилия")
    lazy var firstNameField = UIView().fieldForForm(placeholder: "Имя")
    lazy var surnameField = UIView().fieldForForm(placeholder: "Отчество")
    lazy var dateField = UIView().fieldForForm(placeholder: "Дата рождения")
    lazy var phoneNumberField = UIView().fieldForForm(placeholder: "Номер телефона")
    lazy var commentField = UIView().fieldForForm(placeholder: "Комментарий")
    
//    MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stack = UIStackView(arrangedSubviews: [lastNameField, firstNameField, surnameField, dateField, phoneNumberField, phoneNumberField, commentField])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.anchor(left: leftAnchor,
                     top: topAnchor,
                     right: rightAnchor,
                     bottom: bottomAnchor,
                     paddingLeft: Constants.stackHorizontalPaddings,
                     paddingTop: Constants.stackVerticalPaddings,
                     paddingRight: -Constants.stackHorizontalPaddings,
                     paddingBottom: -Constants.stackVerticalPaddings)
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

