//
//  ExitController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

final class ExitController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseService = DatabaseService()
        DispatchQueue.main.async {
            databaseService.exit { result in
                switch result {
                case .success(_):
                    break
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
        }
        
        let vc = ProfileController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
