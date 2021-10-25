//
//  TabBarController.swift
//  rnova
//
//  Created by Александр Меренков on 10/21/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemOrange
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .black
        
        let recordVC = UINavigationController(rootViewController: RecordController())
        recordVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")
        recordVC.tabBarItem.title = "Запись"
        
        let clinicsVC = UINavigationController(rootViewController: ClinickController())
        clinicsVC.tabBarItem.image = UIImage(systemName: "house")
        clinicsVC.tabBarItem.title = "Клиники"
        viewControllers = [recordVC, clinicsVC]
    }
}
