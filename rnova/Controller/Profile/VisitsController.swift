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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Визиты"
        
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
    
    
    @objc func didTapSegment() {
        print("DEBUG: Tap")
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitCardViewCell.identifire, for: indexPath) as? VisitCardViewCell else { return UICollectionViewCell()}
        cell.dateLabel.text = "07 Декабря 2021, 17:30"
        cell.doctorFullNameLabel.text = "Быков Андрей Евгеньевич"
        cell.doctorProfessionLabel.text = "Терапевт"
        cell.clinicTitleLabel.text = "КДЦ МОЯ Клиника"
        cell.clinicAdressLabel.text = "г. Санкт-Петербург, Выборгский р-н, Луначарского пр., д.12, к.3"
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
