//
//  ServicesViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     
    
    let data = DataLoader().userData
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
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
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}


extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MenuViewController(selectedId: data[indexPath.row])
        

//        let vc = storyboard?.instantiateViewController(identifier: "menu") as! MenuViewController
//
//        let id = data[indexPath.row].id
        vc.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: vc), animated: true)

    }
}


