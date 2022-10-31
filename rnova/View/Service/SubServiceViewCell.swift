//
//  SubServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/18/21.
//

import UIKit

class SubServiceViewCell: UICollectionViewCell {
    static let identifire = "SubServiceViewCell"
    
    let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    let serviceCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        return image
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(serviceNameLabel)
        addSubview(serviceCostLabel)
        addSubview(arrowImage)

        shadow()
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        serviceNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15).isActive = true
        serviceNameLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        serviceCostLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceCostLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        serviceCostLabel.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 5).isActive = true
        serviceCostLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        arrowImage.leftAnchor.constraint(equalTo: serviceNameLabel.rightAnchor, constant: 10).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        arrowImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
