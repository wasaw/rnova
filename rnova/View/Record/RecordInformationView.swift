//
//  RecordInformationView.swift
//  rnova
//
//  Created by Александр Меренков on 11/10/21.
//

import UIKit

class RecordInformationView: UIView {
    
    private let doctorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Врач:"
        return label
    }()
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Специальность:"
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Дата:"
        return label
    }()
    private let clinicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Клиника:"
        return label
    }()
    
    let doctorOutputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let professionOutputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let dateOutputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let clinicOutputLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

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
        
        doctorLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        doctorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        doctorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        doctorLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        professionLabel.translatesAutoresizingMaskIntoConstraints = false
        professionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        professionLabel.topAnchor.constraint(equalTo: doctorLabel.bottomAnchor).isActive = true
        professionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        professionLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: professionLabel.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        clinicLabel.translatesAutoresizingMaskIntoConstraints = false
        clinicLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        clinicLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        clinicLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        clinicLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        doctorOutputLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorOutputLabel.leftAnchor.constraint(equalTo: doctorLabel.rightAnchor, constant: 10).isActive = true
        doctorOutputLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        doctorOutputLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        doctorOutputLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        professionOutputLabel.translatesAutoresizingMaskIntoConstraints = false
        professionOutputLabel.leftAnchor.constraint(equalTo: professionLabel.rightAnchor, constant: 10).isActive = true
        professionOutputLabel.topAnchor.constraint(equalTo: doctorOutputLabel.bottomAnchor).isActive = true
        professionOutputLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        professionOutputLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateOutputLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOutputLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10).isActive = true
        dateOutputLabel.topAnchor.constraint(equalTo: professionOutputLabel.bottomAnchor).isActive = true
        dateOutputLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        dateOutputLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        clinicOutputLable.translatesAutoresizingMaskIntoConstraints = false
        clinicOutputLable.leftAnchor.constraint(equalTo: clinicLabel.rightAnchor, constant: 10).isActive = true
        clinicOutputLable.topAnchor.constraint(equalTo: dateOutputLabel.bottomAnchor).isActive = true
        clinicOutputLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        clinicOutputLable.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
    
}
