//
//  ServiceCardView.swift
//  rnova
//
//  Created by Александр Меренков on 11/22/21.
//

import UIKit

class ServiceCardView: UIView {
    
    let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    let line = UIView()
    let serviceCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(serviceNameLabel)
        addSubview(serviceCostLabel)
        addSubview(line)
        
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.lightGray.cgColor
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        serviceNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        serviceNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        serviceNameLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: serviceNameLabel.bottomAnchor, constant: 5).isActive = true
        line.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        serviceCostLabel.translatesAutoresizingMaskIntoConstraints = false
        serviceCostLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        serviceCostLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5).isActive = true
        serviceCostLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
