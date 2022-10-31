//
//  ExitController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

class ExitController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseService = DatabaseService()
        DispatchQueue.main.async {
            databaseService.exit()
        }
        
        let vc = ProfileController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
