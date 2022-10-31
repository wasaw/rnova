//
//  VisitsController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit
import SideMenu

class VisitsController: UIViewController {
    private let segmentedControl = UISegmentedControl(items: ["Будущие", "Прошедшие"])
    private var collectionView: UICollectionView?
    private var sideMenu: SideMenuNavigationController?
    
    private let databaseService = DatabaseService()
    private var ticketsArray = [Appointment]()
    private var pastTickets = [Appointment]()
    private var futureTickets = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Визиты"
        
        DispatchQueue.main.async {
            self.ticketsArray = self.databaseService.loadDoctorAppointment()
            self.sortingTickets()
            self.collectionView?.reloadData()
        }
        
        configureUI()
        
        view.backgroundColor = .white
    }
    
    func configureUI() {
        configureSideMenu()
        configureSegmentedControl()
        configureCollectionView()
    }
    
    func configureSideMenu() {
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(presentingSideMenu))
        
        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
        sideMenu?.leftSide = true
        sideMenu?.navigationBar.backgroundColor = .systemOrange
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
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(UINib(nibName: VisitCardViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: VisitCardViewCell.identifire)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func sortingTickets() {
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
    
    
    @objc func didTapSegment() {
        collectionView?.reloadData()
    }
    
    @objc func presentingSideMenu() {
        guard let sideMenu = sideMenu else { return }
        present(sideMenu, animated: true)
    }
}

// MARK: - extensions
extension VisitsController: UICollectionViewDelegate {
    
}

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
                cell.dateLabel.text = date + ", " + futureTickets[indexPath.row].time
                cell.doctorFullNameLabel.text = futureTickets[indexPath.row].doctor
                cell.doctorProfessionLabel.text = futureTickets[indexPath.row].profession
                cell.clinicTitleLabel.text = futureTickets[indexPath.row].clinic
                cell.commentLabel.text = futureTickets[indexPath.row].comment
            } else {
                let date = formatter.string(from: pastTickets[indexPath.row].date)
                cell.dateLabel.text = date + ", " + pastTickets[indexPath.row].time
                cell.doctorFullNameLabel.text = pastTickets[indexPath.row].doctor
                cell.doctorProfessionLabel.text = pastTickets[indexPath.row].profession
                cell.clinicTitleLabel.text = pastTickets[indexPath.row].clinic
                cell.commentLabel.text = pastTickets[indexPath.row].comment
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
