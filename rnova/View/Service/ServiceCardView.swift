//
//  ServiceCardView.swift
//  rnova
//
//  Created by Александр Меренков on 11/22/21.
//

import UIKit

private enum Constants {
    static let serviceNameLabelHorizontalPaddings: CGFloat = 10
    static let serviceNameLabelPaddingTop: CGFloat = 5
    static let serviceNameLabelHeight: CGFloat = 45
    static let linePaddingTop: CGFloat = 5
    static let lineHeight: CGFloat = 1
    static let serviceCostLabelpaddingLeading: CGFloat = 10
    static let serviceCostLabelPaddingTop: CGFloat = 5
    static let serviceCostLabelHeight: CGFloat = 30
}

final class ServiceCardView: UIView {
    
//    MARK: - Properties
    
    private lazy var serviceNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    private lazy var line = UIView()
    
    private lazy var serviceCostLabel: UILabel = {
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
        serviceNameLabel.anchor(leading: leadingAnchor,
                                top: topAnchor,
                                trailing: trailingAnchor,
                                paddingLeading: Constants.serviceNameLabelHorizontalPaddings,
                                paddingTop: Constants.serviceNameLabelPaddingTop,
                                paddingTrailing: -Constants.serviceNameLabelHorizontalPaddings,
                                height: Constants.serviceNameLabelHeight)
        line.anchor(leading: leadingAnchor,
                    top: serviceNameLabel.bottomAnchor,
                    trailing: trailingAnchor,
                    paddingTop: Constants.linePaddingTop,
                    height: Constants.lineHeight)
        serviceCostLabel.anchor(leading: leadingAnchor,
                                top: line.bottomAnchor,
                                paddingLeading: Constants.serviceCostLabelpaddingLeading,
                                paddingTop: Constants.serviceCostLabelPaddingTop,
                                height: Constants.serviceCostLabelHeight)
        
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
