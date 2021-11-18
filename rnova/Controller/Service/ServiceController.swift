//
//  ServiceController.swift
//  rnova
//
//  Created by Александр Меренков on 11/16/21.
//

import UIKit

class ServiceController: UIViewController {
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var collectionView: UICollectionView?
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    private var servicesData = [Services]()
    private var filteredSearchResultServices = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.servicesData = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: "").servicesData
            self.collectionView?.reloadData()
        }
        
        configureCollectionView()
        configureStatusBar()
        configureSearchBar()

        view.backgroundColor = .white
    }
    
    func configureStatusBar() {
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = .systemOrange
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationController?.preferredStatusBarStyle
        navigationItem.title = "Услуги"
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(UINib(nibName: ServiceViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: ServiceViewCell.identifire)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: -- extension
extension ServiceController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id: Int
        if searchBarIsEmpty {
            id = servicesData[indexPath.row].id
        } else {
            id = filteredSearchResultServices[indexPath.row].id
        }
        let vc = SubServiceController(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ServiceController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !servicesData.isEmpty {
            if searchBarIsEmpty {
                return servicesData.count
            } else {
                return filteredSearchResultServices.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceViewCell.identifire, for: indexPath) as? ServiceViewCell else { return UICollectionViewCell() }
        if !servicesData.isEmpty {
            if searchBarIsEmpty {
                cell.serviceLabel.text = servicesData[indexPath.row].title
            } else {
                cell.serviceLabel.text = filteredSearchResultServices[indexPath.row].title
            }
        }
        return cell
    }
}

extension ServiceController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height = 80.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
}

extension ServiceController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty {
            filteredSearchResultServices = servicesData.filter({ (list: Services) -> Bool in
                return list.title.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
            })
        }
        collectionView?.reloadData()
    }
}
