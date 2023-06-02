//
//  ClinicViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/16/21.
//

import UIKit

private enum Constants {
    static let stackPaddings: CGFloat = 10
}

protocol SendMailDelegate: AnyObject {
    func sendEmail()
}

protocol CallPhoneDelegate: AnyObject {
    func callPhone(_ phone: String)
}

final class ClinicViewCell: UICollectionViewCell {
    static let identifire = "ClinicViewCell"
    
//    MARK: - Properties
    
    weak var emailDelegate: SendMailDelegate?
    weak var phoneDelegate: CallPhoneDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemOrange
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Позвонить", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setImage(UIImage(systemName: "phone"), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .lightGray
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        return btn
    }()
    
//    MARK: - Lifecyle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendMail))
        emailLabel.addGestureRecognizer(tap)
        configureUI()
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel, emailLabel, phoneLabel, button])
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 6
        addSubview(stack)
        stack.anchor(leading: leadingAnchor,
                     top: topAnchor,
                     trailing: trailingAnchor,
                     bottom: bottomAnchor,
                     paddingLeading: Constants.stackPaddings,
                     paddingTop: Constants.stackPaddings,
                     paddingTrailing: -Constants.stackPaddings,
                     paddingBottom: -Constants.stackPaddings)
    }
    
    func setInformation(_ clinic: Clinic) {
        titleLabel.text = clinic.title
        addressLabel.text = clinic.address
        emailLabel.text = clinic.email
        phoneLabel.text = clinic.mobile
    }
    
//    MARK: - Helpers
    
    @objc private func sendMail() {
        emailDelegate?.sendEmail()
    }
    
    @objc private func handleButtonAction() {
        guard let phone = phoneLabel.text else { return }
        phoneDelegate?.callPhone(phone)
    }
}
