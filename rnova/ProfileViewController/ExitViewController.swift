//
//  ExitViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/25/21.
//

import UIKit
import CoreData

class ExitViewController: UIViewController {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        do {
            let result = try context.fetch(fetchRequest)
            guard let user = result.first as? NSManagedObject else { return }
            user.setValue(false, forKey: "login")
            try context.save()
        } catch {
            print(error)
        }
        
        
//        let vc = ProfileViewController()
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    



}
