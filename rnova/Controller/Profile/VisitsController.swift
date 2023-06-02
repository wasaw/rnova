//
//  VisitsController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

private enum Constants {
    static let segmentedHorizontalPaddings: CGFloat = 20
    static let segmentedPaddingTop: CGFloat = 30
    static let segmentedHeight: CGFloat = 30
}

final class VisitsController: UIViewController {
    
//    MARK: - Properties
    
    private lazy var segmentedControl = UISegmentedControl(items: ["Будущие", "Прошедшие"])
    private var collectionView: UICollectionView?
    
    private let databaseService = DatabaseService.shared
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
        configureSegmentedControl()
        configureCollectionView()
    }
    
    private func configureSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.anchor(leading: view.leadingAnchor,
                                top: view.safeAreaLayoutGuide.topAnchor,
                                trailing: view.trailingAnchor,
                                paddingLeading: Constants.segmentedHorizontalPaddings,
                                paddingTop: Constants.segmentedPaddingTop,
                                paddingTrailing: -Constants.segmentedHorizontalPaddings,
                                height: Constants.segmentedHeight)
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
