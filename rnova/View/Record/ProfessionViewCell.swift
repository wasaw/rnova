//
//  ProfessionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 10/25/21.
//

import UIKit

class ProfessionViewCell: UICollectionViewCell {
    static let identifire = "ProfessionViewCell"
    
    let specialtyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(specialtyLabel)
        
        shadow()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        specialtyLabel.translatesAutoresizingMaskIntoConstraints = false
        specialtyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        specialtyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
    }

}
