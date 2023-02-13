//
//  ServiceCardView.swift
//  rnova
//
//  Created by Александр Меренков on 11/22/21.
//

import UIKit

final class ServiceCardView: UIView {
    
//    MARK: - Properties
    
    private let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private let line = UIView()
    
    private let serviceCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
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
        addSubview(line)
        serviceNameLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, paddingLeft: 10, paddingTop: 5, paddingRight: -10, height: 45)
        line.anchor(left: leftAnchor, top: serviceNameLabel.bottomAnchor, right: rightAnchor, paddingTop: 5, height: 1)
        serviceCostLabel.anchor(left: leftAnchor, top: line.bottomAnchor, paddingLeft: 10, paddingTop: 5, height: 30)
        
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func shadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func setInformation(name: String, cost: String) {
        serviceNameLabel.text = name
        serviceCostLabel.text = cost
    }
}
