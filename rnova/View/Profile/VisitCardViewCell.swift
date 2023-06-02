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
        dateLabel.anchor(leading: leadingAnchor,
                         top: topAnchor,
                         trailing: trailingAnchor,
                         paddingLeading: Constants.dateLabelPaddings,
                         paddingTop: Constants.dateLabelPaddings,
                         paddingTrailing: -Constants.dateLabelPaddings,
                         height: Constants.dateLabelHeight)
        line.anchor(leading: leadingAnchor,
                    top: dateLabel.bottomAnchor,
                    trailing: trailingAnchor,
                    paddingTop: Constants.linePaddingTop,
                    height: Constants.lineHeight)
        doctorFullNameLabel.anchor(leading: leadingAnchor,
                                   top: line.bottomAnchor,
                                   trailing: trailingAnchor,
                                   paddingLeading: Constants.doctorFullNameLabelPaddings,
                                   paddingTop: Constants.doctorFullNameLabelPaddings,
                                   paddingTrailing: -Constants.doctorFullNameLabelPaddings,
                                   height: Constants.doctorFullNameLabelHeight)
        doctorProfessionLabel.anchor(leading: leadingAnchor,
                                     top: doctorFullNameLabel.bottomAnchor,
                                     trailing: trailingAnchor,
                                     paddingLeading: Constants.doctorProfessionLabelPaddings,
                                     paddingTrailing: -Constants.doctorProfessionLabelPaddings,
                                     height: Constants.doctorProfessionLabelHeight)
        clinicTitleLabel.anchor(leading: leadingAnchor,
                                top: doctorProfessionLabel.bottomAnchor,
                                trailing: trailingAnchor,
                                paddingLeading: Constants.clinicTitleLabelHorizontalPaddings,
                                paddingTop: Constants.clinicTitleLabelPaddingTop,
                                paddingTrailing: -Constants.clinicTitleLabelHorizontalPaddings)
        commentLabel.anchor(leading: leadingAnchor,
                            top: clinicTitleLabel.bottomAnchor,
                            trailing: trailingAnchor,
                            paddingLeading: Constants.commentLabelPaddings,
                            paddingTrailing: -Constants.commentLabelPaddings,
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
