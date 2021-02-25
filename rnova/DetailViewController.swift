////
////  DetailViewController.swift
////  rnova
////
////  Created by Александр Меренков on 2/8/21.
////
//
//import UIKit
//
//class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemCategory.items.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath)
//        cell.textLabel?.text = itemCategory.items[indexPath.row]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//    
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellDetail")
//        return table
//    }()
//   
//    var itemCategory: ListCategory!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = itemCategory.title
//        
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        print(itemCategory.items)
//        view.backgroundColor = .darkGray
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        tableView.frame = view.bounds
//    }
//}
