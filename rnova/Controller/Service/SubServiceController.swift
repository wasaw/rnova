//
//  SubServiceController.swift
//  rnova
//
//  Created by Александр Меренков on 11/18/21.
//

import UIKit

class SubServiceController: UIViewController {
    private let serviceId: Int
    
    init(id: Int) {
        self.serviceId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор услуги"
        
        print("DEBUG \(serviceId)")
        view.backgroundColor = .magenta
    }
}
