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
    let insents = UIEdgeInsets(top: 90, left: 20, bottom: 0, right: 20)
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
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
        collectoinView.addSubview(searchController.searchBar)
        definesPresentationContext = true

        
        data.sort {(lhs, rhs)  in return lhs.title < rhs.title}
        
    }
    
}

//    MARK: - Extendion
extension ServicesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id: Int
        if isFiltering {
            id = filteredSearchResult[indexPath.row].id
        }else {
            id = data[indexPath.row].id
        }
        let vc = SubServiceController(id: id)
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
        return CGSize(width: view.frame.width - 40, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
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

