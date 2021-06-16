//
//  ResultViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//

import UIKit
import SideMenu

class VisitViewController: UIViewController {
    
    private var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(sideMenu))
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.navigationBar.backgroundColor = .systemOrange
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        let items = ["Будущие", "Прошедшие"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.backgroundColor = .orange
        customSC.frame = CGRect(x: 10, y: 110, width: view.frame.width - 20, height: 30)
        self.view.addSubview(customSC)
        
        let labelAnswer = UILabel(frame: CGRect(x: 10, y: 170, width: 170, height: 20))
        labelAnswer.text = "Нет результатов"
        labelAnswer.textColor = .black
        view.addSubview(labelAnswer)
        
        view.backgroundColor = .white
    }
    
    @objc func sideMenu() {
        guard let menu = menu else { return }
        present(menu, animated: true)
    }
 

}

//class MenuListController: UITableViewController {
//    let items = ["Профиль", "Визиты", "Выход"]
//    let vc = [ProfileViewController(), VisitViewController(), ExitViewController()]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .white
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = items[indexPath.row]
//        cell.textLabel?.textColor = .black
//        cell.backgroundColor = .white
//        let backgroundView = UIView()
//        backgroundView.backgroundColor = .systemOrange
//        cell.selectedBackgroundView = backgroundView
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        navigationController?.pushViewController(vc[indexPath.row], animated: true)
//    }
//}
