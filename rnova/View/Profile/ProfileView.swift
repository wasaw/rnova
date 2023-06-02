//
//  ProfileView.swift
//  rnova
//
//  Created by Александр Меренков on 12/2/21.
//

import UIKit

private enum Constants {
    static let phoneLabelHeight: CGFloat = 60
    static let lastnameTitleLabelpaddingLeading: CGFloat = 10
    static let lastnameTitleLabelPaddingTop: CGFloat = 40
    static let lastnameTitleLabelHeight: CGFloat = 15
    static let lastnameUserLabelpaddingLeading: CGFloat = 10
    static let lastnameUserLabelPaddingTop: CGFloat = 5
    static let lastnameUserLabelHeight: CGFloat = 30
    static let firstnameTitleLabelpaddingLeading: CGFloat = 10
    static let firstnameTitleLabelPaddingTop: CGFloat = 20
    static let firstnameTitleLabelHeight: CGFloat = 15
    static let firstnameUserLabelpaddingLeading: CGFloat = 10
    static let firstnameUserLabelPaddingTop: CGFloat = 5
    static let firstnameUserLabelHeight: CGFloat = 30
    static let surnameTitleLabelpaddingLeading: CGFloat = 10
    static let surnameTitleLabelPaddingTop: CGFloat = 20
    static let surnameTitleLabelHeight: CGFloat = 15
    static let surnameUserLabelpaddingLeading: CGFloat = 10
    static let surnameUserLabelPaddingTop: CGFloat = 5
    static let surnameUserLabelHeight: CGFloat = 30
    static let dateTitleLabelpaddingLeading: CGFloat = 10
    static let dateTitleLabelPaddingTop: CGFloat = 20
    static let dateTitleLabelHeight: CGFloat = 15
    static let dateUserLabelpaddingLeading: CGFloat = 10
    static let dateUserLabelPaddingTop: CGFloat = 5
    static let dateUserLabelHeight: CGFloat = 30
}

final class ProfileView: UIView {
    
//    MARK: - Properties
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.backgroundColor = .lightGray
        return label
    }()
    
    private lazy var lastnameTitleLabel = UILabel().profileTitleLabel("Фамилия")
    private lazy var lastnameUserLabel = UILabel().profileLabel(size: 21)
    private lazy var firstnameTitleLabel = UILabel().profileTitleLabel("Имя")
    private lazy var firstnameUserLabel = UILabel().profileLabel()
    private lazy var surnameTitleLabel = UILabel().profileTitleLabel("Отчество")
    private lazy var surnameUserLabel = UILabel().profileLabel()
    private lazy var dateTitleLabel = UILabel().profileTitleLabel("Дата рождения", size: 12)
    private lazy var dateUserLabel = UILabel().profileLabel()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurePhone()
        configureLastname()
        configureFirstname()
        configureSurname()
        configureDate()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configurePhone() {
        addSubview(phoneLabel)
        phoneLabel.anchor(leading: leadingAnchor,
                          top: topAnchor,
                          trailing: trailingAnchor,
                          height: Constants.phoneLabelHeight)
    }
    
    private func configureLastname() {
        addSubview(lastnameTitleLabel)
        addSubview(lastnameUserLabel)
        lastnameTitleLabel.anchor(leading: leadingAnchor,
                                  top: phoneLabel.bottomAnchor,
                                  trailing: trailingAnchor,
                                  paddingLeading: Constants.lastnameTitleLabelpaddingLeading,
                                  paddingTop: Constants.lastnameTitleLabelPaddingTop,
                                  height: Constants.lastnameTitleLabelHeight)
        lastnameUserLabel.anchor(leading: leadingAnchor,
                                 top: lastnameTitleLabel.bottomAnchor,
                                 trailing: trailingAnchor,
                                 paddingLeading: Constants.lastnameUserLabelpaddingLeading,
                                 paddingTop: Constants.lastnameUserLabelPaddingTop,
                                 height: Constants.lastnameUserLabelHeight)
    }
    
    private func configureFirstname() {
        addSubview(firstnameTitleLabel)
        addSubview(firstnameUserLabel)
        firstnameTitleLabel.anchor(leading: leadingAnchor,
                                   top: lastnameUserLabel.bottomAnchor,
                                   trailing: trailingAnchor,
                                   paddingLeading: Constants.firstnameTitleLabelpaddingLeading,
                                   paddingTop: Constants.firstnameTitleLabelPaddingTop,
                                   height: Constants.firstnameTitleLabelHeight)
        firstnameUserLabel.anchor(leading: leadingAnchor,
                                  top: firstnameTitleLabel.bottomAnchor,
                                  trailing: trailingAnchor,
                                  paddingLeading: Constants.firstnameUserLabelpaddingLeading,
                                  paddingTop: Constants.firstnameUserLabelPaddingTop,
                                  height: Constants.firstnameUserLabelHeight)
    }
    
    private func configureSurname() {
        addSubview(surnameTitleLabel)
        addSubview(surnameUserLabel)
        surnameTitleLabel.anchor(leading: leadingAnchor,
                                 top: firstnameUserLabel.bottomAnchor,
                                 trailing: trailingAnchor,
                                 paddingLeading: Constants.surnameTitleLabelpaddingLeading,
                                 paddingTop: Constants.surnameTitleLabelPaddingTop,
                                 height: Constants.surnameTitleLabelHeight)
        surnameUserLabel.anchor(leading: leadingAnchor,
                                top: surnameTitleLabel.bottomAnchor,
                                trailing: trailingAnchor,
                                paddingLeading: Constants.surnameUserLabelpaddingLeading,
                                paddingTop: Constants.surnameUserLabelPaddingTop,
                                height: Constants.surnameUserLabelHeight)
    }
    
    private func configureDate() {
        addSubview(dateTitleLabel)
        addSubview(dateUserLabel)
        dateTitleLabel.anchor(leading: leadingAnchor,
                              top: surnameUserLabel.bottomAnchor,
                              trailing: trailingAnchor,
                              paddingLeading: Constants.dateTitleLabelpaddingLeading,
                              paddingTop: Constants.dateTitleLabelPaddingTop,
                              height: Constants.dateTitleLabelHeight)
        dateUserLabel.anchor(leading: leadingAnchor,
                             top: dateTitleLabel.bottomAnchor,
                             trailing: trailingAnchor,
                             paddingLeading: Constants.dateUserLabelpaddingLeading,
                             paddingTop: Constants.dateUserLabelPaddingTop,
                             height: Constants.dateUserLabelHeight)
    }
    
    func setInformation(_ user: User) {
        lastnameUserLabel.text = user.lastname
        firstnameUserLabel.text = user.firstname
        surnameUserLabel.text = user.surname
        dateUserLabel.text = user.date
        phoneLabel.text = "  " + user.phoneNumber
    }
}
