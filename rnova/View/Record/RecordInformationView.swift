//
//  RecordInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

private enum Constants {
    static let doctorLabelPaddings: CGFloat = 10
    static let doctorLabelWidth: CGFloat = 50
    static let doctorLabelHeight: CGFloat = 30
    static let professionLabelpaddingLeading: CGFloat = 10
    static let professionLabelWidth: CGFloat = 130
    static let professionLabelHeight: CGFloat = 30
    static let dateLabelpaddingLeading: CGFloat = 10
    static let dateLabelWidth: CGFloat = 50
    static let dateLabelHeight: CGFloat = 30
    static let clinicLabelpaddingLeading: CGFloat = 10
    static let clinicLabelWidth: CGFloat = 80
    static let clinicLabelHeight: CGFloat = 30
    static let outputLabelPaddings: CGFloat = 10
    static let outputLabelHeight: CGFloat = 30
}

final class RecordInformationView: UIView {
    
//  MARK: - Properties
    
    private lazy var doctorLabel = UILabel().recordLabel("Врач:")
    private lazy var professionLabel = UILabel().recordLabel("Специальность:")
    private lazy var dateLabel = UILabel().recordLabel("Дата:")
    private lazy var clinicLabel = UILabel().recordLabel("Клиника:")
    
    private lazy var doctorOutputLabel = UILabel().recordOutputLabel()
    private lazy var professionOutputLabel = UILabel().recordOutputLabel()
    private lazy var dateOutputLabel = UILabel().recordOutputLabel()
    private lazy var clinicOutputLable = UILabel().recordOutputLabel("Моя клиника")
//    MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(doctorLabel)
        addSubview(professionLabel)
        addSubview(dateLabel)
        addSubview(clinicLabel)
        addSubview(doctorOutputLabel)
        addSubview(professionOutputLabel)
        addSubview(dateOutputLabel)
        addSubview(clinicOutputLable)
        
        doctorLabel.anchor(leading: leadingAnchor,
                           top: topAnchor,
                           paddingLeading: Constants.doctorLabelPaddings,
                           paddingTop: Constants.doctorLabelPaddings,
                           width: Constants.doctorLabelWidth,
                           height: Constants.doctorLabelHeight)
        professionLabel.anchor(leading: leadingAnchor,
                               top: doctorLabel.bottomAnchor,
                               paddingLeading: Constants.professionLabelpaddingLeading,
                               width: Constants.professionLabelWidth,
                               height: Constants.professionLabelHeight)
        dateLabel.anchor(leading: leadingAnchor,
                         top: professionLabel.bottomAnchor,
                         paddingLeading: Constants.dateLabelpaddingLeading,
                         width: Constants.dateLabelWidth,
                         height: Constants.dateLabelHeight)
        clinicLabel.anchor(leading: leadingAnchor,
                           top: dateLabel.bottomAnchor,
                           paddingLeading: Constants.clinicLabelpaddingLeading,
                           width: Constants.clinicLabelWidth,
                           height: Constants.clinicLabelHeight)
        doctorOutputLabel.anchor(leading: doctorLabel.trailingAnchor,
                                 top: topAnchor,
                                 trailing: trailingAnchor,
                                 paddingLeading: Constants.outputLabelPaddings,
                                 paddingTop: Constants.outputLabelPaddings,
                                 paddingTrailing: -Constants.outputLabelPaddings,
                                 height: Constants.outputLabelHeight)
        professionOutputLabel.anchor(leading: professionLabel.trailingAnchor,
                                     top: doctorOutputLabel.bottomAnchor,
                                     trailing: trailingAnchor,
                                     paddingLeading: Constants.outputLabelPaddings,
                                     paddingTrailing: -Constants.outputLabelPaddings,
                                     height: Constants.outputLabelHeight)
        dateOutputLabel.anchor(leading: dateLabel.trailingAnchor,
                               top: professionOutputLabel.bottomAnchor,
                               trailing: trailingAnchor,
                               paddingLeading: Constants.outputLabelPaddings,
                               paddingTrailing: -Constants.outputLabelPaddings,
                               height: Constants.outputLabelHeight)
        clinicOutputLable.anchor(leading: clinicLabel.trailingAnchor,
                                 top: dateOutputLabel.bottomAnchor,
                                 trailing: trailingAnchor,
                                 paddingLeading: Constants.outputLabelPaddings,
                                 paddingTrailing: -Constants.outputLabelPaddings,
                                 height: Constants.outputLabelHeight)
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    func setInformation(_ doctor: Doctor, date: String) {
        doctorOutputLabel.text = doctor.name
        professionOutputLabel.text = doctor.profession_titles
        dateOutputLabel.text = date
    }
}
