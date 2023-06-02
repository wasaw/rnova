//
//  ServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/17/21.
//

import UIKit

private enum Constants {
    static let serviceLabelPaddings: CGFloat = 10
    static let arrowImagepaddingTrailing: CGFloat = 20
    static let arrowImageDimensions: CGFloat = 20
}

final class ServiceViewCell: UICollectionViewCell {
    static let identifire = "ServiceViewCell"
    
//    MARK: - Properties
    
    private lazy var serviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
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
        serviceLabel.anchor(leading: leadingAnchor,
                            trailing: arrowImageView.leadingAnchor,
                            paddingLeading: Constants.serviceLabelPaddings,
                            paddingTrailing: Constants.serviceLabelPaddings)
        
        arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImageView.anchor(leading: serviceLabel.trailingAnchor,
                              trailing: trailingAnchor,
                              paddingTrailing: -Constants.arrowImagepaddingTrailing,
                              width: Constants.arrowImageDimensions,
                              height: Constants.arrowImageDimensions)
    }
    
    func setTitle(_ title: String) {
        serviceLabel.text = title
    }
}
