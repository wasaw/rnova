//
//  ProfileViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//
import SideMenu
import UIKit
import CoreData

class ProfileViewController: UIViewController {

    private let lastNameLabel = UILabel()
    private let firstNameLabel = UILabel()
    
    private var menu: SideMenuNavigationController?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !checkRegistration() {
            let vc = Registration()
            navigationController?.pushViewController(vc, animated: true)
            print("DEBUG: we don'n have person")
        } else {
            if checkLogIn() {
                
                print("DEBUG: person login")
            } else {
                let vc = Login()
                navigationController?.pushViewController(vc, animated: true)
                print("DEBUG: person logout")
            }
        }
        
        getPersonInformation()
        
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(sideMenu))
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.navigationBar.backgroundColor = .systemOrange
        //        menu?.navigationController?.navigationBar.backgroundColor = .systemOrange
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        lastNameLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 40)
        lastNameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        lastNameLabel.textAlignment = .center
//        line(y: 170)
        view.addSubview(lastNameLabel)
        
        firstNameLabel.frame = CGRect(x: 20, y: 140, width: view.bounds.width - 40, height: 40)
        firstNameLabel.font = UIFont.systemFont(ofSize: 23)
        firstNameLabel.textAlignment = .center
        view.addSubview(firstNameLabel)
        
        view.backgroundColor = .white
    }
        
    func checkRegistration() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.isEmpty {
                print("DEBUG: result is empty")
                return false
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func checkLogIn() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            if let user = result.first as? NSManagedObject {
                let checkLogIn = user.value(forKey: "login") as? Bool ?? false
                if checkLogIn {
                    return true
                }
            }
        } catch {
            print(error)
        }
        return false
    }
    
//    func checkLogIn() -> Bool {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            guard let user = result.first as? NSManagedObject else { return false}
//            let check = user.value(forKey: "login") as? Bool ?? false
//            if check { return true}
//        } catch {
//            print(error)
//        }
//        return false
//    }
    
    @objc func sideMenu() {
        guard let menu = menu else { return }
        present(menu, animated: true)
    }
    
    func getPersonInformation() {
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                if let data = data as? NSManagedObject {
//                    print(data.value(forKey: "login") as? Bool)
                    lastNameLabel.text = data.value(forKey: "lastname") as? String ?? ""
                    let name = data.value(forKey: "firstname") as? String ?? ""
                    let surname = data.value(forKey: "surname") as? String ?? ""
                    firstNameLabel.text = name + " " + surname
//                    print(data.value(forKey: "lastname") as? String ?? "")
                }
            }
        } catch {
            print(error)
        }
    }
    
    
}

class MenuListController: UITableViewController {
    let items = ["Профиль", "Визиты", "Выход"]
    let vc = [ProfileViewController(), VisitViewController(), ExitViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemOrange
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc[indexPath.row], animated: true)
    }
}

