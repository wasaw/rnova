//
//  ServiceCard.swift
//  rnova
//
//  Created by Александр Меренков on 11/19/21.
//

import UIKit

class ServiceCardController: UIViewController {
    
//    MARK: - Properties
    
    private let serviceCardView = ServiceCardView()
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
        serviceCardView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingLeft: 10, paddingTop: 20, paddingRight: -10, height: 100)
        let cost = serviceCardCost + " руб."
        serviceCardView.setInformation(name: serviceCardName, cost: cost)
    }
}

