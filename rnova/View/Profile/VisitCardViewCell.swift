//
//  VisitCardViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/7/21.
//

import UIKit

class VisitCardViewCell: UICollectionViewCell {
    static let identifire = "VisitCardViewCell"
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let line = UIView()
    let doctorFullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    let doctorProfessionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let clinicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    let clinicAdressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(dateLabel)
        addSubview(line)
        addSubview(doctorFullNameLabel)
        addSubview(doctorProfessionLabel)
        addSubview(clinicTitleLabel)
        addSubview(clinicAdressLabel)
        
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.lightGray.cgColor
        
        shadow()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        doctorFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorFullNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        doctorFullNameLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10).isActive = true
        doctorFullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        doctorFullNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        doctorProfessionLabel.translatesAutoresizingMaskIntoConstraints = false
        doctorProfessionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        doctorProfessionLabel.topAnchor.constraint(equalTo: doctorFullNameLabel.bottomAnchor).isActive = true
        doctorProfessionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        doctorProfessionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        clinicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        clinicTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        clinicTitleLabel.topAnchor.constraint(equalTo: doctorProfessionLabel.bottomAnchor, constant: 5).isActive = true
        clinicTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        clinicAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        clinicAdressLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        clinicAdressLabel.topAnchor.constraint(equalTo: clinicTitleLabel.bottomAnchor).isActive = true
        clinicAdressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        clinicAdressLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

}
