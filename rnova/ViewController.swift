//
//  ViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/20/21.
//

import UIKit

struct ListCategory {
    let title: String
    let items: [String]
}

///dataSource
let nameArray = ["Иван", "Борис", "Любовь", "Феликс", "Марина", "Людмила"]
let surnameArray = ["Натанович", "Аркадьевич", "Михайловна", "Александрович", "Ивановна", "Петровна"]
let lastnameArray = ["Купитман", "Левин", "Скрябина", "Тютчев", "Капустина", "Кукушкина"]
let professionArray = ["Урология", "Терапевтия", "", "Стоматология", "Диагностика", "Гинекология"]
let experiensArray = [30, 10, 0, 0, 0, 21]


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    private let data: [ListCategory] = [
        ListCategory(title: "BMW", items: ["1 series", "2 series", "3 series"]),
        ListCategory(title: "Mersedes", items: ["A class", "B class", "C class"]),
        ListCategory(title: "AUDI", items: ["A1", "A2", "A3"])
    ]
//    private let list = ["First", "Second", "Third"]
    private var filteredResult = [ListCategory ]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView.reloadData()
        
// setup the SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        stackView.backgroundColor = .red
        view.addSubview(stackView)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let detailVC = segue.destination as! DetailViewController
////                detailVC.titleList = list[indexPath.row]
//                
//                detailVC.itemCategory = data[indexPath.row]
//            }
//        }
//    }

}
// MARK: - UITableViewDataSourse
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredResult.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if isFiltering {
            cell.textLabel?.text = filteredResult[indexPath.row].title
        }else {
            cell.textLabel?.text = data[indexPath.row].title
        }
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        let item: ListCategory
        
        if isFiltering {
            item = filteredResult[indexPath.row]
        }else {
            item = data[indexPath.row]
        }
        vc.itemCategory = item
       // vc.title = data[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
//        performSegue(withIdentifier: "showDetail", sender: self)
        //         present(SecondViewController(), animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredResult = data.filter({(list: ListCategory) -> Bool in
            return list.title.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
}


