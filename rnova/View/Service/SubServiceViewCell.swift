//
//  SubServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/18/21.
//

import UIKit

class SubServiceViewCell: UICollectionViewCell {
    static let identifire = "SubServiceViewCell"
    
//    MARK: - Properties
    
    private let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private let serviceCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        return image
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(serviceNameLabel)
        addSubview(serviceCostLabel)
        addSubview(arrowImage)
        serviceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
        serviceNameLabel.anchor(left: leftAnchor, paddingLeft: 10, height: 45)

        serviceCostLabel.anchor(left: leftAnchor, top: serviceNameLabel.bottomAnchor, paddingLeft: 10, paddingTop: 5, height: 20)
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImage.anchor(left: serviceNameLabel.rightAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: -10, width: 20, height: 20)
    }
    
    func setInformation(title: String, cost: String) {
        serviceNameLabel.text = title
        serviceCostLabel.text = cost
    }
}
