//
//  ResultViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//

import UIKit
import SideMenu
import CoreData

struct Records {
    var doctor: String
    var date: String
    var clinic: String
    var comment: String
    
    init(doctor: String, date: String, clinic: String, comment: String) {
        self.doctor = doctor
        self.date = date
        self.clinic = clinic
        self.comment = comment
    }
}

class VisitViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let insents = UIEdgeInsets(top: 70, left: 20, bottom: 20, right: 20)
    
    private var collectionView: UICollectionView?
    
    private var menu: SideMenuNavigationController?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private var arrayRecords = [Records]()
    
    private var doctorData: [Doctors] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
        print("DEBUG: doctor count \(doctorData.count)")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout:  layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(VisitCollectionViewCell.self, forCellWithReuseIdentifier: VisitCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(sideMenu))
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.navigationBar.backgroundColor = .systemOrange
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        let items = ["Будущие", "Прошедшие"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.backgroundColor = .orange
        customSC.frame = CGRect(x: 10, y: 110, width: view.frame.width - 20, height: 30)
        self.view.addSubview(customSC)
        
        if loadVisit() {
            print("DEBUG: We have records")
        } else {
            let labelAnswer = UILabel(frame: CGRect(x: 10, y: 170, width: 170, height: 20))
            labelAnswer.text = "Нет результатов"
            labelAnswer.textColor = .black
            view.addSubview(labelAnswer)
        }
        
        view.backgroundColor = .white
    }
    
    @objc func sideMenu() {
        guard let menu = menu else { return }
        present(menu, animated: true)
    }
    
    func loadVisit() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        print("DEBUG: load")
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 0 { return false }
            for item in result {
                if let visit = item as? NSManagedObject {
                    let doctorId = visit.value(forKey: "doctor") as? Int ?? 0
                    var doctorName = ""
                    
                    for item in doctorData {
                        if item.id == doctorId {
                            doctorName = item.name
                            break
                        }
                    }
                    let itemRecord = Records(
                        doctor: doctorName,
                        date: visit.value(forKey: "date") as? String ?? "",
                        clinic: visit.value(forKey: "clinic") as? String ?? "",
                        comment: visit.value(forKey: "comment") as? String ?? ""
                    )

                    print(itemRecord.doctor)
                    arrayRecords.append(itemRecord)
                }
//                else {
//                    print("Don't have a imformation")
//                }
            }
        } catch {
            print(error)
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayRecords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitCollectionViewCell.identifier, for: indexPath) as? VisitCollectionViewCell else { return UICollectionViewCell() }
        
        cell.dateLabel.text = arrayRecords[indexPath.row].date
        cell.doctorLabel.text = arrayRecords[indexPath.row].doctor
        cell.clinicLabel.text = arrayRecords[indexPath.row].clinic
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }

}
