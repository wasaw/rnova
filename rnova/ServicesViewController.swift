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
        serviseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ServiceCell")
        
        let text = data[indexPath.row].id
        cell.textLabel?.text = String(text)
//        cell.textLabel?.text = serviseArr[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}


extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension ServicesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}


//func  parse(pathForFile: String) {
////    let data = try! Data(contentsOf: URL(fileURLWithPath: pathForFile))
//
////    let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
//
//    guard let url = URL(string: pathForFile) else { return }
//
//    URLSession.shared.dataTask(with: url) {(data, response, error) in
//
//
//        do {
//
//            let users = try JSONDecoder().decode([Users].self, from: data!)
//
//            for user in users {
////                print("User id: \(user.id), title: \(user.title)")
////                users.append(user)
//            }
//
//            DispatchQueue.main.async {
//
//            }
//        }
//        catch {
//            print("There was an error finding in the data! ")
//        }
//    }.resume()
//
//
//}
//
//struct Users: Decodable {
//    let id: Int
//    let title: String
//    let body: String
//}
