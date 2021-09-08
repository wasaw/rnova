//
//  SpecialtyCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 4/16/21.
//

import UIKit

class SpecialtyCollectionViewCell: UICollectionViewCell {
    static let identifier = "SpecialtyCollectionViewCell"
    
    let doctorImageView = UIImageView()
    private let doctorImage = UIImage(systemName: "person")
    let labelNoTime = UILabel()
    private var timeButtons: [UIButton] = []
    let labelDoctorName = UILabel()
    let labelProfession = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        labelDoctorName.textColor = .black
        labelDoctorName.font = UIFont.boldSystemFont(ofSize: 19)
        labelDoctorName.numberOfLines = 0
        self.addSubview(labelDoctorName)
        
        
        labelProfession.font = labelProfession.font.withSize(18)
        labelProfession.lineBreakMode = .byWordWrapping
        labelProfession.numberOfLines = 0
        labelProfession.textColor = .gray
        self.addSubview(labelProfession)
        
        doctorImageView.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        doctorImageView.layer.cornerRadius = 25
        doctorImageView.layer.masksToBounds = false
        doctorImageView.clipsToBounds = true
        doctorImageView.image = doctorImage
        self.addSubview(doctorImageView)
        
        labelNoTime.textColor = .black
        labelNoTime.text = "Нет свободного времени"
        labelNoTime.isHidden = true
        self.addSubview(labelNoTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelDoctorName.frame = CGRect(x: 100, y: 10, width: contentView.frame.width - 120, height: 60)
        labelProfession.frame = CGRect(x: 100, y: 60, width: contentView.bounds.width - 120, height: 100)
        doctorImageView.frame = CGRect(x: 20, y: 30, width: 60, height: 60)
        labelNoTime.frame = CGRect(x: 20, y: 180, width: 250, height: 20)

        line(y: 160)
    }
}

