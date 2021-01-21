//
//  ViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let list = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
//        tableView.dataSource = self
    }

}
// MARK: - UITableViewDataSourse
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = list[ indexPath.row ]
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

