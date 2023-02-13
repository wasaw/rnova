//
//  RecordInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

final class RecordInformationView: UIView {
    
//  MARK: - Properties
    
    private let doctorLabel = UILabel().recordLabel("Врач:")
    private let professionLabel = UILabel().recordLabel("Специальность:")
    private let dateLabel = UILabel().recordLabel("Дата:")
    private let clinicLabel = UILabel().recordLabel("Клиника:")
    
    private let doctorOutputLabel = UILabel().recordOutputLabel()
    private let professionOutputLabel = UILabel().recordOutputLabel()
    private let dateOutputLabel = UILabel().recordOutputLabel()
    private let clinicOutputLable = UILabel().recordOutputLabel("Моя клиника")
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
        
        doctorLabel.anchor(left: leftAnchor, top: topAnchor, paddingLeft: 10, paddingTop: 10, width: 50, height: 30)
        professionLabel.anchor(left: leftAnchor, top: doctorLabel.bottomAnchor, paddingLeft: 10, width: 130, height: 30)
        dateLabel.anchor(left: leftAnchor, top: professionLabel.bottomAnchor, paddingLeft: 10, width: 50, height: 30)
        clinicLabel.anchor(left: leftAnchor, top: dateLabel.bottomAnchor, paddingLeft: 10, width: 80, height: 30)
        doctorOutputLabel.anchor(left: doctorLabel.rightAnchor, top: topAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 10, paddingRight: -10, height: 30)
        professionOutputLabel.anchor(left: professionLabel.rightAnchor, top: doctorOutputLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, height: 30)
        dateOutputLabel.anchor(left: dateLabel.rightAnchor, top: professionOutputLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, height: 30)
        clinicOutputLable.anchor(left: clinicLabel.rightAnchor, top: dateOutputLabel.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, height: 30)
        
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
