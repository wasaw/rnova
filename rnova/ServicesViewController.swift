//
//  ServicesViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ServicesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     
    
    var data = DataLoader().doctorsData
    
    private var filteredSearchResult = [Doctors]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        data.sort {(lhs, rhs)  in return lhs.title < rhs.title}
        
//        setup the SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    
    
}

extension ServicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSearchResult.count
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ServiceCell")
        if isFiltering {
            cell.textLabel?.text = filteredSearchResult[indexPath.row].title
        }else {
            cell.textLabel?.text = data[indexPath.row].title
        }
//        let text = data[indexPath.row].title
//        cell.textLabel?.text = text
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}


extension ServicesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: Doctors
        if isFiltering {
            item = filteredSearchResult[indexPath.row]
        }else {
            item = data[indexPath.row]
        }
        let vc = MenuViewController(selectedId: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ServicesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredSearchResult = data.filter({ (list: Doctors) -> Bool in
            return list.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}


