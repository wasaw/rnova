//
//  VisitCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 7/6/21.
//

import UIKit

class VisitCollectionViewCell: UICollectionViewCell {
    static let identifier = "VisitCollectionViewCell"

    var dateLabel = UILabel()
    var doctorLabel = UILabel()
    var clinicLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateLabel.textColor = .black
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(dateLabel)
        
        doctorLabel.textColor = .black
        doctorLabel.font = UIFont.systemFont(ofSize: 19)
        self.addSubview(doctorLabel)
        
        clinicLabel.textColor = .black
        clinicLabel.font = UIFont.systemFont(ofSize: 19)
        self.addSubview(clinicLabel)
        
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.frame = CGRect(x: 20, y: 10, width: contentView.bounds.width - 40, height: 30)
        line(y: 45)
        doctorLabel.frame = CGRect(x: 20, y: 50, width: contentView.bounds.width - 40, height: 30)
        clinicLabel.frame = CGRect(x: 20, y: 80, width: contentView.bounds.width - 40, height: 30)
    }
    
}
