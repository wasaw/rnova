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
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        
        let recordVC = UINavigationController(rootViewController: RecordController())
        recordVC.tabBarItem.image = UIImage(systemName: "square.and.pencil")
        recordVC.tabBarItem.title = "Запись"
        
        let clinicsVC = UINavigationController(rootViewController: ClinicsController())
        clinicsVC.tabBarItem.image = UIImage(systemName: "house")
        clinicsVC.tabBarItem.title = "Клиники"
        
        let profileVC = UINavigationController(rootViewController: ProfileController())
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle")
        profileVC.tabBarItem.title = "Профиль"
        
        let serviceVC = UINavigationController(rootViewController: ServiceController())
        serviceVC.tabBarItem.image = UIImage(systemName: "list.dash")
        serviceVC.tabBarItem.title = "Услуги"
        viewControllers = [recordVC, clinicsVC, serviceVC, profileVC]
    }
}
