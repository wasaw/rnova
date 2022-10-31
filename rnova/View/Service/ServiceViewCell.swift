//
//  ServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/17/21.
//

import UIKit

class ServiceViewCell: UICollectionViewCell {
    static let identifire = "ServiceViewCell"
    
    let serviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .gray
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        shadow()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(serviceLabel)
        addSubview(arrowImageView)
        
        serviceLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        serviceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: 10).isActive = true
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.leftAnchor.constraint(equalTo: serviceLabel.rightAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
