//
//  ServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/17/21.
//

import UIKit

final class ServiceViewCell: UICollectionViewCell {
    static let identifire = "ServiceViewCell"
    
//    MARK: - Properties
    
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .gray
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
        addSubview(serviceLabel)
        addSubview(arrowImageView)
        serviceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceLabel.anchor(left: leftAnchor, right: arrowImageView.leftAnchor, paddingLeft: 10, paddingRight: 10)
        
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.anchor(left: serviceLabel.rightAnchor, right: rightAnchor, paddingRight: -20, width: 20, height: 20)
    }
    
    func setTitle(_ title: String) {
        serviceLabel.text = title
    }
}
