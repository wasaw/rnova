//
//  VisitCardViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/7/21.
//

import UIKit

private enum Constants {
    static let dateLabelPaddings: CGFloat = 10
    static let dateLabelHeight: CGFloat = 30
    static let linePaddingTop: CGFloat = 10
    static let lineHeight: CGFloat = 1
    static let doctorFullNameLabelPaddings: CGFloat = 10
    static let doctorFullNameLabelHeight: CGFloat = 25
    static let doctorProfessionLabelPaddings: CGFloat = 10
    static let doctorProfessionLabelHeight: CGFloat = 25
    static let clinicTitleLabelHorizontalPaddings: CGFloat = 10
    static let clinicTitleLabelPaddingTop: CGFloat = 5
    static let commentLabelPaddings: CGFloat = 10
    static let commentLabelHeight: CGFloat = 45
}

final class VisitCardViewCell: UICollectionViewCell {
    static let identifire = "VisitCardViewCell"
    
//    MARK: - Properties
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    private lazy var line = UIView()
    
    private lazy var doctorFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    
    private lazy var doctorProfessionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var clinicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
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
        dateLabel.anchor(left: leftAnchor,
                         top: topAnchor,
                         right: rightAnchor,
                         paddingLeft: Constants.dateLabelPaddings,
                         paddingTop: Constants.dateLabelPaddings,
                         paddingRight: -Constants.dateLabelPaddings,
                         height: Constants.dateLabelHeight)
        line.anchor(left: leftAnchor,
                    top: dateLabel.bottomAnchor,
                    right: rightAnchor,
                    paddingTop: Constants.linePaddingTop,
                    height: Constants.lineHeight)
        doctorFullNameLabel.anchor(left: leftAnchor,
                                   top: line.bottomAnchor,
                                   right: rightAnchor,
                                   paddingLeft: Constants.doctorFullNameLabelPaddings,
                                   paddingTop: Constants.doctorFullNameLabelPaddings,
                                   paddingRight: -Constants.doctorFullNameLabelPaddings,
                                   height: Constants.doctorFullNameLabelHeight)
        doctorProfessionLabel.anchor(left: leftAnchor,
                                     top: doctorFullNameLabel.bottomAnchor,
                                     right: rightAnchor,
                                     paddingLeft: Constants.doctorProfessionLabelPaddings,
                                     paddingRight: -Constants.doctorProfessionLabelPaddings,
                                     height: Constants.doctorProfessionLabelHeight)
        clinicTitleLabel.anchor(left: leftAnchor,
                                top: doctorProfessionLabel.bottomAnchor,
                                right: rightAnchor,
                                paddingLeft: Constants.clinicTitleLabelHorizontalPaddings,
                                paddingTop: Constants.clinicTitleLabelPaddingTop,
                                paddingRight: -Constants.clinicTitleLabelHorizontalPaddings)
        commentLabel.anchor(left: leftAnchor,
                            top: clinicTitleLabel.bottomAnchor,
                            right: rightAnchor,
                            paddingLeft: Constants.commentLabelPaddings,
                            paddingRight: -Constants.commentLabelPaddings,
                            height: Constants.commentLabelHeight)
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
