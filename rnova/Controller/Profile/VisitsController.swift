//
//  VisitsController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit
import SideMenu

final class VisitsController: UIViewController {
    
//    MARK: - Properties
    
    private let segmentedControl = UISegmentedControl(items: ["Будущие", "Прошедшие"])
    private var collectionView: UICollectionView?
    private var sideMenu: SideMenuNavigationController?
    
    private let databaseService = DatabaseService()
    private var ticketsArray = [Appointment]()
    private var pastTickets = [Appointment]()
    private var futureTickets = [Appointment]()
    
//  MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Визиты"
        
        loadInformation()
        configureUI()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func loadInformation() {
        DispatchQueue.main.async {
            self.databaseService.loadDoctorAppointment { (result: RequestStatus<[Appointment]>) in
                switch result {
                case .success(let answer):
                    self.ticketsArray = answer
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
            self.sortingTickets()
            self.collectionView?.reloadData()
        }
    }
    
    private func configureUI() {
        configureSideMenu()
        configureSegmentedControl()
        configureCollectionView()
    }
    
    private func configureSideMenu() {
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(presentingSideMenu))
        
        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
        sideMenu?.leftSide = true
        sideMenu?.navigationBar.backgroundColor = .systemOrange
    }
    
    private func configureSegmentedControl() {
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
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(VisitCardViewCell.self, forCellWithReuseIdentifier: VisitCardViewCell.identifire)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func sortingTickets() {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        for item in ticketsArray {
            let ticketDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: item.date)
            if Calendar.current.date(from: dateComponents)! <= Calendar.current.date(from: ticketDateComponents)! {
                futureTickets.append(item)
            } else {
                pastTickets.append(item)
            }
        }
    }
    
//    MARK: - Selecters
    
    @objc func didTapSegment() {
        collectionView?.reloadData()
    }
    
    @objc func presentingSideMenu() {
        guard let sideMenu = sideMenu else { return }
        present(sideMenu, animated: true)
    }
}

// MARK: - Extensions

extension VisitsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pastTickets.isEmpty && futureTickets.isEmpty {
            return 0
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return futureTickets.count
            } else {
                return pastTickets.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitCardViewCell.identifire, for: indexPath) as? VisitCardViewCell else { return UICollectionViewCell()}
        if !pastTickets.isEmpty || !futureTickets.isEmpty {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy"
            if segmentedControl.selectedSegmentIndex == 0 {
                let date = formatter.string(from: futureTickets[indexPath.row].date)
                cell.setInformation(futureTickets[indexPath.row], date: date)
            } else {
                let date = formatter.string(from: pastTickets[indexPath.row].date)
                cell.setInformation(pastTickets[indexPath.row], date: date)
            }
        }
        return cell
    }
}

extension VisitsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40
        let height = 190.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
