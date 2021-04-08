//
//  ServicesViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ServicesViewController: UIViewController {
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectoinView: UICollectionView!
    
    let cellID = "ServicesCell"
    let insents = UIEdgeInsets(top: 70, left: 20, bottom: 10, right: 20)
    private var filteredSearchResult = [Services]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    var data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: "").servicesData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectoinView.delegate = self
        collectoinView.dataSource = self
        collectoinView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        collectoinView.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        collectoinView.addSubview(searchController.searchBar)
        definesPresentationContext = true

        
        data.sort {(lhs, rhs)  in return lhs.title < rhs.title}
        
    }
    
}

extension ServicesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id: Int
        if isFiltering {
            id = filteredSearchResult[indexPath.row].id
        }else {
            id = data[indexPath.row].id
        }
        let vc = SubServicesViewController(selectedId: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ServicesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSearchResult.count
        }else {
            return data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ServicesCell else { return UICollectionViewCell() }
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        if isFiltering {
            cell.label.text = filteredSearchResult[indexPath.row].title
        }else {
            cell.label.text = data[indexPath.row].title
        }
        return cell
    }
}

extension ServicesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
}

extension ServicesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredSearchResult = data.filter({ (list: Services) -> Bool in
            return list.title.lowercased().contains(searchText.lowercased())
        })
        collectoinView.reloadData()
    }
}

//class ServicesViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
////    var data = DataLoader(urlParameter: "&category_id=14264").servicesData
////    let strRequest = "&category_id=14264"
//    var data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: "").servicesData
//
//    private var filteredSearchResult = [Services]()
//    private var searchController = UISearchController(searchResultsController: nil)
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.reloadData()
//
//        data.sort {(lhs, rhs)  in return lhs.title < rhs.title}
//
////        setup the SearchController
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//    }
//
//}
//
//extension ServicesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredSearchResult.count
//        }
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ServiceCell")
//        if isFiltering {
//            cell.textLabel?.text = filteredSearchResult[indexPath.row].title
//        }else {
//            cell.textLabel?.text = data[indexPath.row].title
//        }
////        let text = data[indexPath.row].title
////        cell.textLabel?.text = text
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//
//}
//
//
//extension ServicesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item: Int
//        if isFiltering {
////            item = filteredSearchResult[indexPath.row]
//            item = filteredSearchResult[indexPath.row].id
//        }else {
////            item = data[indexPath.row]
//            item = data[indexPath.row].id
//        }
//        let vc = SubServicesViewController(selectedId: item)
////        let vc = SubServicesViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension ServicesViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    private func filterContentForSearchText(_ searchText: String) {
//        filteredSearchResult = data.filter({ (list: Services) -> Bool in
//            return list.title.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//}
//
//
