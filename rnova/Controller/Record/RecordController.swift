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
    private let insents = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
        DispatchQueue.main.async {
            self.doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
            self.collectionView?.reloadData()
        }
    
        let statusBar = UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = .systemOrange
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationController?.preferredStatusBarStyle
        navigationItem.title = "Запись"
        }

    
    func configureUI() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.systemOrange.cgColor
        segmentedControl.backgroundColor = .systemOrange
        
        segmentedControl.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
        
        collectonViewSetup()
    }
    
    @objc func didTapSegment() {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("DEBUG: selected 0")
        } else {
            print("DEBUG: selected 1")
        }
    }
    
    func collectonViewSetup() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: RecordViewCell.identifite, bundle: nil), forCellWithReuseIdentifier: RecordViewCell.identifite)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant:  20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//    MARK: -- extension
extension RecordController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if doctorsData.count != 0 {
            return doctorsData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordViewCell.identifite, for: indexPath) as? RecordViewCell else { return UICollectionViewCell() }
        if doctorsData.count != 0 {
            if doctorsData[indexPath.row].avatar_small != nil {
                cell.profileImageView.downloaded(from: doctorsData[indexPath.row].avatar_small!)
            }
            cell.surnameLabel.text = doctorsData[indexPath.row].name
            cell.professionLabel.text = doctorsData[indexPath.row].profession_titles
        }
        return cell
    }
}

extension RecordController: UICollectionViewDelegate {
    
}

extension RecordController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width - 20, height: width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
}
