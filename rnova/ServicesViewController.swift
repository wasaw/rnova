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
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
    }

}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        serviseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ServiceCell")
        cell.textLabel?.text = serviseArr[indexPath.row]
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
