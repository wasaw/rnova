//
//  ViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/20/21.
//

import UIKit

class ViewController: UIViewController {

    var doctorVC: UIView!
    var specialtyVC: UIView!
    var doctorsData = [Doctors]()
    var professionsData = [Professions]()
        
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
    
    var checkTapSegment = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
            self.professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
            activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
        
        collectonViewSetup()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width:  collectionView.bounds.width - 5, height: 50)
        collectionView.addSubview(searchController.searchBar)

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
        }else {
            checkTapSegment = false
            collectionView.reloadData()
        }
    }
}

//    MARK: -- extension
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
        
        if doctorsData[indexPath.row].avatar_small != nil {
            cell.profileImageView.downloaded(from: doctorsData[indexPath.row].avatar_small!)
        }
        
        if checkTapSegment {
            cell.profileImageView.isHidden = false
            cell.label.frame = CGRect(x: 120, y: 20, width: cell.frame.width - 145, height: 50)
            cell.label.lineBreakMode = .byWordWrapping
            cell.label.numberOfLines = 2
            if isFiltering {
                cell.label.text = filteredSearchResultDoctors[indexPath.row].name
            }else {
                cell.label.text = doctorsData[indexPath.row].name
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
            cell.label.frame = CGRect(x: 15, y: 5, width: cell.frame.width - 15, height: 50)
            if isFiltering {
                cell.label.text = filteredSearchResultProfessions[indexPath.row].name
            }else {
                cell.label.text = "\(professionsData[indexPath.row].name) (\(commonCount))"
            }
        }
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id: Int
        let vc: UIViewController
        if checkTapSegment {
            if isFiltering {
                id = filteredSearchResultDoctors[indexPath.row].id
                vc = DoctorChoiceViewController(id: id)
            }else {
                id = doctorsData[indexPath.row].id
                vc = DoctorChoiceViewController(id: id)
            }
        }else {
            if isFiltering {
                id = filteredSearchResultProfessions[indexPath.row].id
                vc = SpecialtyChoiceViewController(id: id)
            }else {
                id = professionsData[indexPath.row].id
                vc = SpecialtyChoiceViewController(id: id)
            }
        }
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
