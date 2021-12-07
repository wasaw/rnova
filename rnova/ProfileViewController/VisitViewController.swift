////
////  ResultViewController.swift
////  rnova
////
////  Created by Александр Меренков on 1/22/21.
////
//
//import UIKit
//import SideMenu
//import CoreData
//
//struct Records {
//    var doctor: String
//    var date: Date
//    var clinic: String
//    var comment: String
//    var relevance: Bool
//    
//    init(doctor: String, date: Date, clinic: String, comment: String, relevance: Bool) {
//        self.doctor = doctor
//        self.date = date
//        self.clinic = clinic
//        self.comment = comment
//        self.relevance = relevance
//    }
//}
//
//class VisitViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    private let insents = UIEdgeInsets(top: 70, left: 20, bottom: 20, right: 20)
//    
//    private var collectionView: UICollectionView?
//    
//    private var menu: SideMenuNavigationController?
//    
//    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//    private var arrayRecordsLoad = [Records]()
//    private var arrayRecordsVisible = [Records]()
//    
//    private var doctorData: [Doctors] = []
//    
//    private var checkTapSegmen = true
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout:  layout)
//        guard let collectionView = collectionView else { return }
//        
//        collectionView.register(VisitCollectionViewCell.self, forCellWithReuseIdentifier: VisitCollectionViewCell.identifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.frame = view.bounds
//        collectionView.backgroundColor = .white
//        view.addSubview(collectionView)
//        
//        let imageBar = UIImage(systemName: "line.horizontal.3")
//        navigationController?.navigationBar.tintColor = .white
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(sideMenu))
//        
//        menu = SideMenuNavigationController(rootViewController: MenuListController())
//        menu?.leftSide = true
//        menu?.navigationBar.backgroundColor = .systemOrange
//        
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//        
//        navigationItem.setHidesBackButton(true, animated: false)
//        
//        let items = ["Будущие", "Прошедшие"]
//        let customSC = UISegmentedControl(items: items)
//        customSC.selectedSegmentIndex = 0
//        customSC.backgroundColor = .orange
//        customSC.frame = CGRect(x: 10, y: 110, width: view.frame.width - 20, height: 30)
//        customSC.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
//        self.view.addSubview(customSC)
//        
//        if !loadVisit() {
//            let labelAnswer = UILabel(frame: CGRect(x: 10, y: 170, width: 170, height: 20))
//            labelAnswer.text = "Нет результатов"
//            labelAnswer.textColor = .black
//            view.addSubview(labelAnswer)
//        }
//        
//        view.backgroundColor = .white
//    }
//    
//    @objc func sideMenu() {
//        guard let menu = menu else { return }
//        present(menu, animated: true)
//    }
//    
//    @objc func didTapSegment(sender: UISegmentedControl) {
//        if sender.selectedSegmentIndex == 0 {
//            checkTapSegmen = true
//            collectionView?.reloadData()
//        } else {
//            checkTapSegmen = false
//            collectionView?.reloadData()
//        }
//    }
//    
//    func loadVisit() -> Bool {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.count == 0 { return false }
//            for item in result {
//                if let visit = item as? NSManagedObject {
//                    let doctorId = visit.value(forKey: "doctor") as? Int ?? 0
//                    var doctorName = ""
//                    
//                    for item in doctorData {
//                        if item.id == doctorId {
//                            doctorName = item.name
//                            break
//                        }
//                    }
//                    
//                    let nowDay = Date()
//                    let checkDate = visit.value(forKey: "date") as? Date ?? Date()
//                    var checkRelevance: Bool
//                    if nowDay < checkDate {
//                        checkRelevance = true
//                    } else {
//                        checkRelevance = false
//                    }
//                    
//                    let itemRecord = Records(
//                        doctor: doctorName,
//                        date: visit.value(forKey: "date") as? Date ?? Date(),
//                        clinic: visit.value(forKey: "clinic") as? String ?? "",
//                        comment: visit.value(forKey: "comment") as? String ?? "",
//                        relevance: checkRelevance
//                    )
//                    arrayRecordsLoad.append(itemRecord)
//                }
//            }
//        } catch {
//            print(error)
//        }
//        
//        return true
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        arrayRecordsVisible = []
//        if checkTapSegmen {
//            for item in arrayRecordsLoad {
//                if item.relevance {
//                    arrayRecordsVisible.append(item)
//                }
//            }
//        } else {
//            for item in arrayRecordsLoad {
//                if !item.relevance {
//                    arrayRecordsVisible.append(item)
//                }
//            }
//        }
//        return arrayRecordsVisible.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisitCollectionViewCell.identifier, for: indexPath) as? VisitCollectionViewCell else { return UICollectionViewCell() }
//       
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy HH:mm"
//        let dateString = formatter.string(from: arrayRecordsVisible[indexPath.row].date)
//        cell.dateLabel.text = dateString
//        cell.doctorLabel.text = arrayRecordsVisible[indexPath.row].doctor
//        cell.clinicLabel.text = arrayRecordsVisible[indexPath.row].clinic
//    
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width - 40, height: 150)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return insents
//    }
//
//}
