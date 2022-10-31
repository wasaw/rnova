//
//  ServiceCard.swift
//  rnova
//
//  Created by Александр Меренков on 11/19/21.
//

import UIKit

class ServiceCardController: UIViewController {
    
    private let serviceCardView = ServiceCardView()
    private let serviceCardName: String
    private let serviceCardCost: String
    
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
    
    func configureServiceCard() {
        view.addSubview(serviceCardView)
        
        serviceCardView.translatesAutoresizingMaskIntoConstraints = false
        serviceCardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        serviceCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        serviceCardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        serviceCardView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        serviceCardView.serviceNameLabel.text = serviceCardName
        serviceCardView.serviceCostLabel.text = serviceCardCost + " руб."
    }
}

