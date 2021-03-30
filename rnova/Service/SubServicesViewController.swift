//
//  DetailViewController.swift
//  rnova
//
//  Created by Александр Меренков on 2/8/21.
//

import UIKit


class SubServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView?
    private let selectedId: Int
    private var noResult = false
    let insents = UIEdgeInsets(top: 70, left: 20, bottom: 10, right: 20)


    init(selectedId: Int) {
        self.selectedId = selectedId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var filteredSearchResult = [Services]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering:Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выбор услуги"
        
        strReques = "&category_id=" + String(self.selectedId)
        data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData
        data.sort { (lth, rth) -> Bool in
            return lth.title < rth.title
        }
        
        
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        collectionView.addSubview(searchController.searchBar)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data.count == 0 {
            return 1
        }
        else if isFiltering {
            return filteredSearchResult.count
        }else {
            return data.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        if data.count == 0 {
            cell.label.text = "Нет результатов"
            noResult = true
        }else if isFiltering {
            cell.label.text = filteredSearchResult[indexPath.row].title
            }else {
                cell.label.text = data[indexPath.row].title
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !noResult else {return}
        let item: Int
        if isFiltering {
            item = filteredSearchResult[indexPath.row].id
        }else {
            item = data[indexPath.row].id
        }
        let vc = SubServicesViewController(selectedId: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}

var strReques = ""
var data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData

extension SubServicesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredSearchResult = data.filter({(list: Services) -> Bool in return list.title.lowercased().contains(searchText.lowercased())})
        collectionView?.reloadData()
    }
}

//class SubServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if data.count == 0 {
//            return 1
//        }else if isFiltering {
//            return filteredSearchResult.count
//        }else {
//            return data.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubService", for: indexPath)
//        if data.count == 0 {
//            cell.textLabel?.text = "Нет результатов"
//            noResult = true
//        }else if isFiltering {
//            cell.textLabel?.text = filteredSearchResult[indexPath.row].title
//        }else {
//            cell.textLabel?.text = data[indexPath.row].title
//        }
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let item: Int
//        guard !noResult else { return }
//        if isFiltering {
//            item = filteredSearchResult[indexPath.row].id
//        } else {
//            print(noResult)
//            item = data[indexPath.row].id
//        }
//        let vc = SubServicesViewController(selectedId: item)
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellSubService")
//        return table
//    }()
//
//    private let selectedId: Int
//    private var noResult = false
////    public var strRequest = "&category_id="
//    init(selectedId: Int) {
//        self.selectedId = selectedId
////        self.strRequest += String(selectedId)
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private var filteredSearchResult = [Services]()
//    private var searchController = UISearchController(searchResultsController: nil)
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {
//            return false
//        }
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Выбор услуги"
//
//        strReques = "&category_id=" + String(self.selectedId)
//        data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        data.sort { (lhs, rhs) in
//            return lhs.title < rhs.title
//        }
////        setup the SearchController
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        tableView.frame = view.bounds
//    }
//}
//
//var strReques = ""
//var data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData
//
//extension SubServicesViewController: UISearchResultsUpdating {
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
