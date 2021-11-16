//
//  RecordController.swift
//  rnova
//
//  Created by Александр Меренков on 10/13/21.
//

import UIKit

class RecordController: UIViewController {
    
    private let segmentedControl = UISegmentedControl(items: ["Врачи", "Специальности"])
    private var collectionView: UICollectionView?
    private var doctorsData = [Doctors]()
    private var professionsData = [Professions]()
    private var quantityProfession = [Int: Int]()
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    private var isDoctorChoice = true
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var filteredSearchResultDoctors = [Doctors]()
    private var filteredSearchResultProfessions = [Professions]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
        DispatchQueue.main.async {
            self.doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
            self.professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
            self.collectionView?.reloadData()
            self.countingQuantityOfProfessions()
        }
    }

    
    func configureUI() {
        configureSegmentedControl()
        configureStatusBar()
        configureSearchBar()
        configureCollectionView()
    }
    
    func configureSegmentedControl() {
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.systemOrange.cgColor
        segmentedControl.backgroundColor = .systemOrange
        
        segmentedControl.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
    }
    
    func configureStatusBar() {
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = .systemOrange
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationController?.preferredStatusBarStyle
        navigationItem.title = "Запись"
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController

        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white        
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        searchController.searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: RecordViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: RecordViewCell.identifire)
        collectionView.register(UINib(nibName: ProfessionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: ProfessionViewCell.identifire)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant:  20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
    }
    
    func countingQuantityOfProfessions() {
        for item in professionsData {
            var quantity = 0
            let id = item.id
            
            for item in doctorsData {
                guard let str = item.profession else { continue }
                if !str.isEmpty {
                    for item in str {
                        if id == Int(item) {
                            quantity += 1
                        }
                    }
                }
                quantityProfession[id] = quantity
            }
        }
    }
    
    @objc func didTapSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            isDoctorChoice = true
            collectionView?.reloadData()
        } else {
            isDoctorChoice = false
            collectionView?.reloadData()
        }
    }
}

//    MARK: -- extension
extension RecordController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if doctorsData.count != 0 && isDoctorChoice {
            if searchBarIsEmpty {
                return doctorsData.count
            } else {
                return filteredSearchResultDoctors.count
            }
        }
        if professionsData.count != 0 && !isDoctorChoice {
            if searchBarIsEmpty {
                return professionsData.count
            } else {
                return filteredSearchResultProfessions.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellDoctor = collectionView.dequeueReusableCell(withReuseIdentifier: RecordViewCell.identifire, for: indexPath) as? RecordViewCell else { return UICollectionViewCell() }
        guard let cellProfession = collectionView.dequeueReusableCell(withReuseIdentifier: ProfessionViewCell.identifire, for: indexPath) as? ProfessionViewCell else { return UICollectionViewCell()}
        if isDoctorChoice {
            if searchBarIsEmpty {
                if doctorsData.count != 0 {
                    if doctorsData[indexPath.row].avatar_small != nil {
                        cellDoctor.profileImageView.downloaded(from: doctorsData[indexPath.row].avatar_small!)
                    }
                    cellDoctor.surnameLabel.text = doctorsData[indexPath.row].name
                    cellDoctor.professionLabel.text = doctorsData[indexPath.row].profession_titles
                }
            } else {
                if doctorsData.count != 0 {
                    if filteredSearchResultDoctors[indexPath.row].avatar_small != nil {
                        cellDoctor.profileImageView.downloaded(from: filteredSearchResultDoctors[indexPath.row].avatar_small!)
                    }
                    cellDoctor.surnameLabel.text = filteredSearchResultDoctors[indexPath.row].name
                    cellDoctor.professionLabel.text = filteredSearchResultDoctors[indexPath.row].profession_titles
                }
            }
            
            return cellDoctor
        } else {
            if searchBarIsEmpty {
                guard let quantity = quantityProfession[professionsData[indexPath.row].id] else { return UICollectionViewCell() }
                cellProfession.specialtyLabel.text = "\(professionsData[indexPath.row].name) (\(quantity))"
            } else {
                guard let quantity = quantityProfession[filteredSearchResultProfessions[indexPath.row].id] else { return UICollectionViewCell() }
                cellProfession.specialtyLabel.text = "\(filteredSearchResultProfessions[indexPath.row].name) (\(quantity))"
            }
            
            return cellProfession
        }
    }
}

extension RecordController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDoctorChoice {
            let id: Int
            searchBarIsEmpty ? ( id = doctorsData[indexPath.row].id) : (id = filteredSearchResultDoctors[indexPath.row].id)
            let vc = DateRecordChoiceController(id: id)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let id: Int
            searchBarIsEmpty ? ( id = professionsData[indexPath.row].id) : (id = filteredSearchResultProfessions[indexPath.row].id)
            let vc = ChooseDoctorByProfession(professionId: id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension RecordController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat
        isDoctorChoice ? (height = width / 4) : (height = 60)
        return CGSize(width: width - 20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
}

extension RecordController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty {
            if isDoctorChoice {
                filteredSearchResultDoctors = doctorsData.filter({ (list: Doctors) -> Bool in
                    return list.name.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
                })
            } else {
                filteredSearchResultProfessions = professionsData.filter({ (list: Professions) -> Bool in
                    return list.name.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
                })
            }
        }
        collectionView?.reloadData()
    }
}
