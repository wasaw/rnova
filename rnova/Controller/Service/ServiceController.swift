//
//  ServiceController.swift
//  rnova
//
//  Created by Александр Меренков on 11/16/21.
//

import UIKit

final class ServiceController: UIViewController {
    
//    MARK: - Properties
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var collectionView: UICollectionView?
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    private var servicesData = [Services]()
    private var filteredSearchResultServices = [Services]()
    
//    MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let statusBar = UIView()
        statusBar.frame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        statusBar.backgroundColor = .systemOrange
        view.addSubview(statusBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInformation()
        configureCollectionView()
        configureNavigationBar()
        configureSearchBar()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func loadInformation() {
        DispatchQueue.main.async {
            NetworkService.shared.request(method: .categories) { (result: RequestStatus<[Services]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    self.servicesData = answer
                    self.collectionView?.reloadData()
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.title = "Услуги"
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(ServiceViewCell.self, forCellWithReuseIdentifier: ServiceViewCell.identifire)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(leading: view.leadingAnchor,
                              top: view.safeAreaLayoutGuide.topAnchor,
                              trailing: view.trailingAnchor,
                              bottom: view.bottomAnchor)
        collectionView.backgroundColor = .white
    }
}

// MARK: - Extensions

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
                let title = servicesData[indexPath.row].title
                cell.setTitle(title)
            } else {
                let title = filteredSearchResultServices[indexPath.row].title
                cell.setTitle(title)
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
