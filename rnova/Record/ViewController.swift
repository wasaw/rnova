//
//  ViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/20/21.
//

import UIKit

class ViewController: UIViewController {
//
//    let doctorVC = DoctorViewController()
//    let specialtyVC = SpecialtyViewController()
//
    var doctorVC: UIView!
    var specialtyVC: UIView!
    
    var doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
    var professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    let cellID = "RecordCollectionViewCell"
    let insents = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    
    private var filteredSearchResultDoctors = [Doctors]()
    private var filteredSearchResultProfessions = [Professions]()
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    let dataColor = [
        UIColor.white
    ]
    
    var checkTapSegment = true
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorVC = DoctorViewController().view
        specialtyVC = SpecialtyViewController().view
//        viewContainer.addSubview(specialtyVC)
//        viewContainer.addSubview(doctorVC)
        
        collectonViewSetup()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width - 5, height: 50)
        collectionView.addSubview(searchController.searchBar)
//        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func collectonViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    @IBAction func didTapSegment(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            checkTapSegment = true
            collectionView.reloadData()
//            viewContainer.bringSubviewToFront(doctorVC)
        }else {
            checkTapSegment = false
            collectionView.reloadData()
//            viewContainer.bringSubviewToFront(specialtyVC)
            
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if checkTapSegment {
            if isFiltering {
                return filteredSearchResultDoctors.count
            }else {
                return doctorsData.count
            }
        }else {
            if isFiltering {
                return filteredSearchResultProfessions.count
            }else {
                return professionsData.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? RecordCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 1
        cell.layer.shadowRadius = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        if checkTapSegment {
            cell.profileImageView.isHidden = false
            cell.label.frame = CGRect(x: 80, y: 20, width: cell.frame.width - 105, height: 40)
            if isFiltering {
                cell.label.text = filteredSearchResultDoctors[indexPath[1]].name
            }else {
                cell.setup(color: dataColor[0])
                cell.label.text = doctorsData[indexPath[1]].name
            }
        }else {
            //counting the number of doctors by profession
            let id = professionsData[indexPath.row].id
            var commonCount = 0
            for item in 0...doctorsData.count - 1 {
                guard let str = doctorsData[item].profession else { continue }
                if str.count > 0 {
                    for i in 0...str.count - 1 {
                        if id == Int(str[i]) {
                            commonCount += 1
                        }
                    }
                }
            }
           
            cell.profileImageView.isHidden = true
            cell.label.frame = CGRect(x: 15, y: 5, width: cell.frame.width - 30, height: 50)
            if isFiltering {
                cell.label.text = filteredSearchResultProfessions[indexPath[1]].name
            }else {
                cell.setup(color: dataColor[0])
                cell.label.text = "\(professionsData[indexPath[1]].name) (\(commonCount))"
            }
        }
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id: Int
        if checkTapSegment {
            if isFiltering {
                id = filteredSearchResultDoctors[indexPath[1]].id
            }else {
                id = doctorsData[indexPath[1]].id
            }
        }else {
            if isFiltering {
                id = filteredSearchResultProfessions[indexPath[1]].id
            }else {
                id = professionsData[indexPath[1]].id
            }
        }
        let vc = SubViewController(id: id, checkTapSegment: checkTapSegment)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 20
        let height: CGFloat
        if checkTapSegment {
            height = width / 4
        }else {
            height = 60
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        if checkTapSegment {
            filteredSearchResultDoctors = doctorsData.filter({ (list: Doctors) -> Bool in
                return list.name.lowercased().contains(searchText.lowercased())
            })
        }else {
            filteredSearchResultProfessions = professionsData.filter({ (list: Professions) -> Bool in
                return list.name.lowercased().contains(searchText.lowercased())
            })
        }
        collectionView.reloadData()
    }
}


//class ViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//
////    private let list = ["First", "Second", "Third"]
////    private var filteredResult = [ListCategory ]()
//    private let searchController = UISearchController(searchResultsController: nil)
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//
//    let stackView = UIStackView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView?.dataSource = self
//        tableView?.delegate = self
//        tableView.reloadData()
//
//// setup the SearchController
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//        stackView.axis = .horizontal
//        stackView.spacing = 5
//
//        stackView.backgroundColor = .red
//        view.addSubview(stackView)
//    }
//
//}
//// MARK: - UITableViewDataSourse
//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
////            return filteredResult.count
//            return 3
//        }
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        if isFiltering {
////            cell.textLabel?.text = filteredResult[indexPath.row].title
//            cell.textLabel?.text = "Filter"
//        }else {
////            cell.textLabel?.text = data[indexPath.row].title
//            cell.textLabel?.text = "data"
//        }
//        return cell
//    }
//
//
//}
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = DetailViewController()
////        let item: ListCategory
//
////        if isFiltering {
////            item = filteredResult[indexPath.row]
////        }else {
////            item = data[indexPath.row]
////        }
////        vc.itemCategory = item
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//extension ViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
//
//    private func filterContentForSearchText(_ searchText: String) {
//        filteredResult = data.filter({(list: ListCategory) -> Bool in
//            return list.title.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }
//}


