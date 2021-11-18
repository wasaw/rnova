////
////  DetailViewController.swift
////  rnova
////
////  Created by Александр Меренков on 2/8/21.
////
//
//import UIKit
//
//
//class SubServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    private var collectionView: UICollectionView?
//    private let selectedId: Int
//    private var noResult = false
//    let insents = UIEdgeInsets(top: 70, left: 20, bottom: 10, right: 20)
//
//    init(selectedId: Int) {
//        self.selectedId = selectedId
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
//    private var isFiltering:Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Выбор услуги"
//
//        strReques = "&category_id=" + String(self.selectedId)
//        data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData
//        data.sort { (lth, rth) -> Bool in
//            return lth.title < rth.title
//        }
//                
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        guard let collectionView = collectionView else { return }
//        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.frame = view.bounds
//        view.addSubview(collectionView)
//        collectionView.backgroundColor = .white
//        
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск"
//        searchController.searchBar.barTintColor = .white
//        definesPresentationContext = true
//        collectionView.addSubview(searchController.searchBar)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if data.count == 0 {
//            return 1
//        }
//        else if isFiltering {
//            return filteredSearchResult.count
//        }else {
//            return data.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
//        if data.count == 0 {
//            cell.label.text = "Нет результатов"
//            noResult = true
//        }else if isFiltering {
//            cell.label.text = filteredSearchResult[indexPath.row].title
//            }else {
//                cell.label.text = data[indexPath.row].title
//            }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width - 50, height: 80)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return insents
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard !noResult else {return}
//        let item: Int
//        if isFiltering {
//            item = filteredSearchResult[indexPath.row].id
//        }else {
//            if (data.isEmpty) {
//                strReques = "&category_id=" + String(self.selectedId)
//                data = DataLoader(urlMethod: "&method=getServiceCategories", urlParameter: strReques).servicesData
//                data.sort { (lth, rth) -> Bool in
//                    return lth.title < rth.title
//                }
//            }
//            item = data[indexPath.row].id
//        }
//        let vc = SubServicesViewController(selectedId: item)
//        navigationController?.pushViewController(vc, animated: true)
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
//        filteredSearchResult = data.filter({(list: Services) -> Bool in return list.title.lowercased().contains(searchText.lowercased())})
//        collectionView?.reloadData()
//    }
//}
//
