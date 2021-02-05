//
//  ServicesViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     
    let serviseArr = ["Консультация", "Вакцинация", "Хирургически стационар", "Диагностические инструменты", "Лаборатория", "Физиотерапия", "Радиоволновая терапия", "Лазерная терапия", "Комплексные программы", "Оформление меддокументации"]
    
//    let model = Model()
    let data = DataLoader().userData

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        
//        NotificationCenter.default.addObserver(forName: Model.nNewsLoaded, object: nil, queue: OperationQueue.main) { (notification) in
//            self.tableView.reloadData()
//
//        }
//        model.loadNewsJson()
        
//          var titleArray = [String]()
//          titleArray = parse(pathForFile: "https://jsonplaceholder.typicode.com/posts")
//        print(titleArray.count)
//        for title in titleArray {
//            print(title)
//        }
//        var users = [Users]()
//        parse(pathForFile: "https://jsonplaceholder.typicode.com/posts")
    }
    
    
    
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ServiceCell")
        
        let text = data[indexPath.row].title
        cell.textLabel?.text = text

//        cell.textLabel?.text = serviseArr[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}


extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MenuViewController(selectedId: data[indexPath.row].id)
        

//        let vc = storyboard?.instantiateViewController(identifier: "menu") as! MenuViewController
//
//        let id = data[indexPath.row].id
        vc.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: vc), animated: true)

    }
}

//class SecondListViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//}
