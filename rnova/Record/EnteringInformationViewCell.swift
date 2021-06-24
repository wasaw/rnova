//
//  EnteringInformationViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 6/18/21.
//

import UIKit

class EnteringInformationViewCell: UICollectionViewCell {
    static let identifire = "EnteringInformationViewCell"
    
    let doctorLabel = UILabel()
    let specialtyLabel = UILabel()
    let dateLabel = UILabel()
    let clinicLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        doctorLabel.textColor = .black
        self.addSubview(doctorLabel)
        
        specialtyLabel.textColor = .black
        specialtyLabel.numberOfLines = 2
        specialtyLabel.lineBreakMode = .byWordWrapping
        self.addSubview(specialtyLabel)
        
        dateLabel.textColor = .black
        self.addSubview(dateLabel)
        
        clinicLabel.textColor = .black
        self.addSubview(clinicLabel)
        
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = .white
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        doctorLabel.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 30)
        specialtyLabel.frame = CGRect(x: 10, y: 30, width: contentView.bounds.width - 20, height: 60)
        dateLabel.frame = CGRect(x: 10, y: 80, width: contentView.bounds.width - 20, height: 30)
        clinicLabel.frame = CGRect(x: 10, y: 110, width: contentView.bounds.width - 20, height: 30)
    }

}
