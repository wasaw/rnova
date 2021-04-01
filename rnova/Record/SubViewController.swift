//
//  SubViewController.swift
//  rnova
//
//  Created by Александр Меренков on 2/26/21.
//

import UIKit

class SubViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView?
    private let doctor_id: Int
    private let checkTapSegment: Bool
    var clinicsData = DataLoader(urlMethod: "&method=getClinics", urlParameter: "").clinicsData
    let insents = UIEdgeInsets(top: 70, left: 20, bottom: 10, right: 20)
    
    private var filteredSearchResult = [Clinic]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering:Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    init(id: Int, checkTapSegment: Bool) {
        self.doctor_id = id
        self.checkTapSegment = checkTapSegment
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор клиники"
        clinicsData.sort { (lth, rth) -> Bool in
            return lth.title < rth.title
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(DoctorCustomCollectionViewCell.self, forCellWithReuseIdentifier: DoctorCustomCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource  = self
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
        if isFiltering {
            return filteredSearchResult.count
        }else {
            return clinicsData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorCustomCollectionViewCell.identifier, for: indexPath) as? DoctorCustomCollectionViewCell else { return UICollectionViewCell()}
        if isFiltering {
            cell.label.text = filteredSearchResult[indexPath.row].title
        }else {
            cell.label.text = clinicsData[indexPath.row].title
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
        let id: Int
        if isFiltering {
            id = doctor_id
        }else {
            id = doctor_id
        }
        if checkTapSegment {
            let vc = DoctorChoiceViewController(id: id, clinicId: clinicsData[indexPath.row].id)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = SpecialtyChoiceViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SubViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchcontroller: UISearchController) {
        filterContentForSearchText(searchcontroller.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredSearchResult = clinicsData.filter({(list: Clinic) -> Bool in return list.title.lowercased().contains(searchText.lowercased())})
        collectionView?.reloadData()
    }
}

//class SubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    var clinicsData = DataLoader(urlMethod: "&method=getClinics", urlParameter: "").clinicsData
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubView", for: indexPath)
//        if indexPath.row == 0 {
//            cell.accessoryType = .disclosureIndicator
//            cell.textLabel?.text = clinicsData[indexPath.section].title
//        }else {
//            if let address = clinicsData[indexPath.section].address,
//               let email = clinicsData[indexPath.section].email,
//               let mobile = clinicsData[indexPath.section].mobile {
//                cell.accessoryType = .none
//
//                let labelAdress = UILabel(frame: CGRect(x: 20, y: 10, width: 400, height: 60))
//                labelAdress.lineBreakMode = .byWordWrapping
//                labelAdress.numberOfLines = 2
//                labelAdress.text = address
//                cell.addSubview(labelAdress)
//
//                let labelEmail = UILabel(frame: CGRect(x: 20, y: 70, width: 200, height: 20))
//                labelEmail.text = email
//                cell.addSubview(labelEmail)
//
//                let labelPhone = UILabel(frame: CGRect(x: 20, y: 100, width: 200, height: 20))
//                labelPhone.text = mobile
//                cell.addSubview(labelPhone)
//            }else {
//                cell.isHidden = true
//            }
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//        if checkTapSegment {
//            let vc = DoctorChoiceViewController(id: doctor_id, clinicId: clinicsData[indexPath.row].id)
//            navigationController?.pushViewController(vc, animated: true)
//        }else {
//            let vc = SpecialtyChoiceViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row % 2 == 0 {
//            return 44
//        }
//        return 130
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return clinicsData.count
//    }
//
//    private let tableView: UITableView = {
//        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
//        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellSubView")
//        return table
//    }()
//
//
//
//
//    let doctor_id: Int
//    let checkTapSegment: Bool
////    let label = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        label.frame = CGRect(x: 40, y: 40, width: 200, height: 200)
////        label.text = String(doctor_id)
////        view.addSubview(label)
//        navigationItem.title = "Выбор клиники"
//        view.addSubview(tableView)
//
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        tableView.frame = view.bounds
//    }
//
//    init(id: Int, checkTapSegment: Bool) {
//        self.doctor_id = id
//        self.checkTapSegment = checkTapSegment
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//
//}



