//
//  VisitCardViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/7/21.
//

import UIKit

class VisitCardViewCell: UICollectionViewCell {
    static let identifire = "VisitCardViewCell"
    
//    MARK: - Properties
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    private let line = UIView()
    
    private let doctorFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    
    private let doctorProfessionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let clinicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(dateLabel)
        addSubview(line)
        addSubview(doctorFullNameLabel)
        addSubview(doctorProfessionLabel)
        addSubview(clinicTitleLabel)
        addSubview(commentLabel)
        dateLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 10, paddingRight: -10, height: 30)
        line.anchor(left: leftAnchor, top: dateLabel.bottomAnchor, right: rightAnchor, paddingTop: 10, height: 1)
        doctorFullNameLabel.anchor(left: leftAnchor, top: line.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 10, paddingRight: -10, height: 25)
        doctorProfessionLabel.anchor(left: leftAnchor, top: doctorFullNameLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, height: 25)
        clinicTitleLabel.anchor(left: leftAnchor, top: doctorProfessionLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, paddingRight: -10)
        commentLabel.anchor(left: leftAnchor, top: clinicTitleLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, height: 45)
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setInformation(_ ticket: Appointment, date: String) {
        dateLabel.text = date + ", " + ticket.time
        doctorFullNameLabel.text = ticket.doctor
        doctorProfessionLabel.text = ticket.profession
        clinicTitleLabel.text = ticket.clinic
        commentLabel.text = ticket.comment
    }

}
