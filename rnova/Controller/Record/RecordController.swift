//
//  RecordController.swift
//  rnova
//
//  Created by Александр Меренков on 10/13/21.
//

import UIKit

private enum Constants {
    static let segmentedHorizontalPaddings: CGFloat = 20
    static let segmentedVerticalPadding: CGFloat = 30
    static let segmentedHeight: CGFloat = 30
    static let collectionViewPaddingTop: CGFloat = 20
}

final class RecordController: UIViewController {
    
//    MARK: - Properties
    
    private let segmentedControl = UISegmentedControl(items: ["Врачи", "Специальности"])
    private var collectionView: UICollectionView?
    private var doctors = [Doctor]()
    private var professionsData = [Professions]()
    private var quantityProfession = [Int: Int]()
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    private var isDoctorChoice = true
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var filteredSearchResultDoctors = [Doctor]()
    private var filteredSearchResultProfessions = [Professions]()

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
        configureUI()
        view.backgroundColor = .white
    }

//    MARK: - Helpers
    
    private func loadInformation() {
        DispatchQueue.main.async {
            NetworkService.shared.request(method: .users) { (result: RequestStatus<[Doctors]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    for item in answer {
                        let downloadImage = UIImageView()
                        if item.avatar_small != nil {
                            downloadImage.downloaded(from: item.avatar_small!)
                        } else {
                            downloadImage.image = UIImage(systemName: "person")
                        }
                        let doc = Doctor(id: item.id,
                                         name: item.name,
                                         profession: item.profession ?? [],
                                         profession_titles: item.profession_titles ?? "Доктор",
                                         image: downloadImage)
                        self.doctors.append(doc)
                    }
                    self.collectionView?.reloadData()
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
            
            NetworkService.shared.request(method: .professions) { (result: RequestStatus<[Professions]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    self.professionsData = answer
                    self.collectionView?.reloadData()
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
            
        }
    }
    
    private func configureUI() {
        configureSegmentedControl()
        configureNavigationBar()
        configureSearchBar()
        configureCollectionView()
    }
    
    private func configureSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.anchor(left: view.leftAnchor,
                                top: view.safeAreaLayoutGuide.topAnchor,
                                right: view.rightAnchor,
                                paddingLeft: Constants.segmentedHorizontalPaddings,
                                paddingTop: Constants.segmentedVerticalPadding,
                                paddingRight: -Constants.segmentedVerticalPadding,
                                height: Constants.segmentedHeight)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.systemOrange.cgColor
        segmentedControl.backgroundColor = .systemOrange
        segmentedControl.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationItem.title = "Запись"
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.barTintColor = .white
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DoctorViewCell.self, forCellWithReuseIdentifier: DoctorViewCell.identifire)
        collectionView.register(ProfessionViewCell.self, forCellWithReuseIdentifier: ProfessionViewCell.identifire)
        
        view.addSubview(collectionView)
        collectionView.anchor(left: view.leftAnchor,
                              top: segmentedControl.bottomAnchor,
                              right: view.rightAnchor,
                              bottom: view.bottomAnchor,
                              paddingTop: Constants.collectionViewPaddingTop)
        collectionView.backgroundColor = .white
    }
        
//    MARK: - Selectors
    
    @objc private func didTapSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            isDoctorChoice = true
            collectionView?.reloadData()
        } else {
            isDoctorChoice = false
            collectionView?.reloadData()
        }
    }
}

//    MARK: - Extensions

extension RecordController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if doctors.count != 0 && isDoctorChoice {
            if searchBarIsEmpty {
                return doctors.count
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
        guard let cellDoctor = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorViewCell.identifire, for: indexPath) as? DoctorViewCell else { return UICollectionViewCell() }
        guard let cellProfession = collectionView.dequeueReusableCell(withReuseIdentifier: ProfessionViewCell.identifire, for: indexPath) as? ProfessionViewCell else { return UICollectionViewCell()}
        if isDoctorChoice {
            if searchBarIsEmpty {
                if !doctors.isEmpty {
                    cellDoctor.setInformation(doctors[indexPath.row])
                }
            } else {
                if !doctors.isEmpty {
                    cellDoctor.setInformation(filteredSearchResultDoctors[indexPath.row])
                }
            }
            
            return cellDoctor
        } else {
            if searchBarIsEmpty {
                let specialty = "\(professionsData[indexPath.row].name)"
                cellProfession.setInformation(specialty)
            } else {
                let specialty = "\(filteredSearchResultProfessions[indexPath.row].name)"
                cellProfession.setInformation(specialty)
            }
            
            return cellProfession
        }
    }
}

extension RecordController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDoctorChoice {
            let doctor: Doctor
            searchBarIsEmpty ? ( doctor = doctors[indexPath.row]) : (doctor = filteredSearchResultDoctors[indexPath.row])
            let vc = DateRecordChoiceController(doctor: doctor)
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
                filteredSearchResultDoctors = doctors.filter({ (list: Doctor) -> Bool in
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
