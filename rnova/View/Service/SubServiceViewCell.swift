//
//  SubServiceViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/18/21.
//

import UIKit

private enum Constants {
    static let serviceNameLabelCenterPadding: CGFloat = 15
    static let serviceNameLabelpaddingLeading: CGFloat = 10
    static let serviceNameLabelHeight: CGFloat = 45
    static let serviceCostLabelpaddingLeading: CGFloat = 10
    static let serviceCostLabelPaddingTop: CGFloat = 5
    static let serviceCostLabelHeight: CGFloat = 20
    static let arrowImagePaddings: CGFloat = 10
    static let arrowDimensions: CGFloat = 20
}

final class SubServiceViewCell: UICollectionViewCell {
    static let identifire = "SubServiceViewCell"
    
//    MARK: - Properties
    
    private lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var serviceCostLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
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
        serviceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Constants.serviceNameLabelCenterPadding).isActive = true
        serviceNameLabel.anchor(leading: leadingAnchor,
                                paddingLeading: Constants.serviceNameLabelpaddingLeading,
                                height: Constants.serviceNameLabelHeight)

        serviceCostLabel.anchor(leading: leadingAnchor,
                                top: serviceNameLabel.bottomAnchor,
                                paddingLeading: Constants.serviceCostLabelpaddingLeading,
                                paddingTop: Constants.serviceCostLabelPaddingTop,
                                height: Constants.serviceCostLabelHeight)
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowImage.anchor(leading: serviceNameLabel.trailingAnchor,
                          trailing: trailingAnchor,
                          paddingLeading: Constants.arrowImagePaddings,
                          paddingTrailing: -Constants.arrowImagePaddings,
                          width: Constants.arrowDimensions,
                          height: Constants.arrowDimensions)
    }
    
    func setInformation(title: String, cost: String) {
        serviceNameLabel.text = title
        serviceCostLabel.text = cost
    }
}
