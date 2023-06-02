//
//  ServiceCard.swift
//  rnova
//
//  Created by Александр Меренков on 11/19/21.
//

import UIKit

private enum Constants {
    static let serviceCardHorizontalPaddings: CGFloat = 10
    static let serviceCardPaddingTop: CGFloat = 20
    static let serviceCardHeight: CGFloat = 100
}

final class ServiceCardController: UIViewController {
    
//    MARK: - Properties
    
    private lazy var serviceCardView = ServiceCardView()
    private let serviceCardName: String
    private let serviceCardCost: String
    
//    MARK: - Lifecycle
    
    init(name: String, cost: String) {
        self.serviceCardName = name
        self.serviceCardCost = cost
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Карточка услуги"
        configureServiceCard()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func configureServiceCard() {
        view.addSubview(serviceCardView)
        serviceCardView.anchor(leading: view.leadingAnchor,
                               top: view.safeAreaLayoutGuide.topAnchor,
                               trailing: view.trailingAnchor,
                               paddingLeading: Constants.serviceCardHorizontalPaddings,
                               paddingTop: Constants.serviceCardPaddingTop,
                               paddingTrailing: -Constants.serviceCardHorizontalPaddings,
                               height: Constants.serviceCardHeight)
        let cost = serviceCardCost + " руб."
        serviceCardView.setInformation(name: serviceCardName, cost: cost)
    }
}

