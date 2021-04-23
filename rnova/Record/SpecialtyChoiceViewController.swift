//
//  SpecialtyViewController.swift
//  rnova
//
//  Created by Александр Меренков on 3/4/21.
//

import UIKit

class SpecialtyChoiceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let id: Int
    private var collectionView: UICollectionView?
    private let insents = UIEdgeInsets(top: 80, left: 20, bottom: 10, right: 20)
    
    var doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
    var professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
    let scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: "").scheduleData
    var arrDoctorId: [Int] = []
    var arrDoctorName: [String] = []
    var arrDoctorProfession: [String] = []
    var arrTimeForDoctor: [String] = []
    var arrAllTime: [[String]] = []
    
//    let textView = UITextView()
    let labelTitle = UILabel()
//    let labelDoctorName = UILabel()
//    let labelProfession = UILabel()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    &user_id=1381
//        print("Schedule: \(scheduleData["1385"])")
        
        let dateFormat = Date()
        let format = DateFormatter()
        format.dateFormat = "dd.MM.yyyy"
//        let nowDay = format.string(from: dateFormat)
        let nowDay = "26.04.2021"
        
        for item in 0...doctorsData.count - 1 {
//            can be more then one
            guard let str = doctorsData[item].profession else { continue }
            if str.count > 0 {
                for i in 0...str.count - 1 {
//                    var textProfession = ""
                    if id == Int(str[i]) {
                        arrDoctorId.append(doctorsData[item].id)
                        arrDoctorName.append(doctorsData[item].name)
                        guard let name = doctorsData[item].profession_titles else { continue }
                        arrDoctorProfession.append(name)
                        guard let strTime = scheduleData[String(doctorsData[item].id)] else {
                            arrTimeForDoctor = []
//                            arrTimeForDoctor.append("")
                            arrAllTime.append(arrTimeForDoctor)
                            continue
                        }
                        if strTime.count > 0 {
                            arrTimeForDoctor = []
                            for k in 0...strTime.count - 1 {
                                if nowDay == strTime[k].date {
                                    arrTimeForDoctor.append(strTime[k].time_start_short)
                                }
                            }
                            arrAllTime.append(arrTimeForDoctor)
                        }else {
                            print("else")
                        }
//                        for j in 0...professionsData.count - 1 {
//                            if id == professionsData[j].id {
//                                textProfession = textProfession + professionsData[j].name
//                            }
//                        }
                    }
//                    if !textProfession.isEmpty {
//                        arrDoctorProfession.append(textProfession)
//                    }
                }
            }
            
            
        }
        
        
        navigationItem.title = "Выбор времени"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(SpecialtyCollectionViewCell.self, forCellWithReuseIdentifier: SpecialtyCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        labelTitle.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 60)
        labelTitle.font = UIFont.boldSystemFont(ofSize: 22)
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 0
        for item in 0...professionsData.count - 1 {
            if professionsData[item].id == id {
                labelTitle.text = professionsData[item].name
                break
            }else {
                labelTitle.text = "Название специальности"
            }
        }
        view.addSubview(labelTitle)
        
        
//
        
        
//        textView.frame = CGRect(x: 20, y: 170, width: view.bounds.width - 40, height: 140)
//        textView.layer.cornerRadius = 10
//        textView.layer.shadowColor = UIColor.black.cgColor
//        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        textView.layer.shadowOpacity = 1
//        textView.layer.shadowRadius = 1.0
//        textView.clipsToBounds = false
//        textView.backgroundColor = .white
//        view.addSubview(textView)
//
//        let doctorImageView = UIImageView()
//        let doctorImage = UIImage(systemName: "person")
//        doctorImageView.frame = CGRect(x: 20, y: 30, width: 60, height: 60)
//        doctorImageView.image = doctorImage
//        textView.addSubview(doctorImageView)
//
//        labelDoctorName.frame = CGRect(x: 100, y: 10, width: textView.frame.width - 120, height: 60)
////        labelDoctorName.text = "Фамилия Имя Отчество"
//        labelDoctorName.font = UIFont.boldSystemFont(ofSize: 19)
//        labelDoctorName.numberOfLines = 2
//        textView.addSubview(labelDoctorName)
//
//        labelProfession.frame = CGRect(x: 100, y: 50, width: textView.bounds.width - 120, height: 90)
//        labelProfession.font = labelProfession.font.withSize(18)
//        labelProfession.lineBreakMode = .byWordWrapping
//        labelProfession.numberOfLines = 4
//        labelProfession.textColor = .gray
//        labelProfession.text = textProfession
//        textView.addSubview(labelProfession)
//
//        //MARK: -line
//        let lineView = UIView(frame: CGRect(x: 0, y: 150, width: textView.frame.width, height: 1))
//        lineView.layer.borderWidth = 1
//        lineView.layer.borderColor = UIColor.lightGray.cgColor
//        textView.addSubview(lineView)

//        view.backgroundColor = .white
    }
    
    //MARK: -collectionView parameters
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var commonCount = 0
//        for item in 0...doctorsData.count - 1 {
//            guard let str = doctorsData[item].profession else { continue }
//            if str.count > 0 {
//                for i in 0...str.count - 1 {
//                    if id == Int(str[i]) {
//                        commonCount += 1
//                    }
//                }
//            }
//        }
        return arrDoctorId.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialtyCollectionViewCell.identifier, for: indexPath) as? SpecialtyCollectionViewCell else { return UICollectionViewCell() }
        
//        var arrDoctor: [Int] = []
//        for item in 0...doctorsData.count - 1 {
////            can be more then one
//            guard let str = doctorsData[item].profession else { continue }
//            if str.count > 0 {
//                for i in 0...str.count - 1 {
//                    if id == Int(str[i]) {
//                        arrDoctor.append(doctorsData[item].id)
//                    }
//                }
//            }
//        }
        
        
        cell.labelDoctorName.text = arrDoctorName[indexPath.row]
        cell.labelProfession.text = arrDoctorProfession[indexPath.row]
        //        var strParameter = ""
//        var doctorId = ""
//        //MARK: - Create profession for description
//        var textProfession = ""
//        for item in 0...doctorsData.count - 1 {
//            guard let str = doctorsData[item].profession else {
//                continue
//            }
//            if str.count > 0 {
//                for i in 0...str.count - 1 {
//                    if Int(str[i]) == id {
//                        cell.labelDoctorName.text = doctorsData[item].name
//                        doctorId = String(doctorsData[item].id)
//                        strParameter = "&user_id=" + doctorId
//                        for j in 0...professionsData.count - 1 {
//                            for g in 0...str.count - 1 {
//                                if professionsData[j].id == Int(str[g]) {
//                                    textProfession = textProfession + professionsData[j].name + " "
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        let searchId = String(arrDoctorId[indexPath.row])
//        let str = "&user_id=" + searchId
//
//        let scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: str).scheduleData
//
//        let dateFormat = Date()
//        let format = DateFormatter()
//        format.dateFormat = "dd.MM.yyyy"
//        let nowDay = format.string(from: dateFormat)
//
//        var countButton = 0
//        var arrTime: [String] = []
//
//
//        if scheduleData.count > 0 {
//            guard let count = scheduleData[searchId]?.count else {
//                return cell
//            }
//            for item in 0...count - 1 {
//                guard let date = scheduleData[searchId]?[item].date else { continue }
//                if nowDay == date {
//                    countButton += 1
//                    guard let time = scheduleData[searchId]?[item].time_start_short else {
//                        continue
//                    }
//                    arrTime.append(time)
//                }
//            }
//        }
        
//        for item in 0...scheduleData[searchId]!.count - 1 {
//            guard let date = scheduleData[searchId]?[item].date else { continue }
////            if "23.04.2021" == date {
//            if nowDay == date {
//                countButton += 1
//                guard let time = scheduleData[searchId]?[item].time_start_short else {
//                    continue
//                }
//                arrTime.append(time)
//            }
//
//        }
        if arrAllTime[indexPath.row].count > 0 {
            cell.createButton(for: arrAllTime[indexPath.row].count, arrTime: arrAllTime[indexPath.row])
        }else {
            cell.createButton(for: 0, arrTime: [""])
        }
        
        
        
        
//        cell.labelProfession.text = textProfession
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let compare = arrAllTime[indexPath.row].count
        let hight: Int
        switch compare {
        case 0, 1, 2, 3, 4:
            hight = 230
        case 5, 6, 7, 8:
            hight = 275
        case 9, 10, 11, 12:
            hight = 330
        default:
            hight = 230
        }
//        if arrAllTime[indexPath.row].count <= 4 {
//            let hight = 230
//        }
        
//        if countButton == 0 {
//            hight = 230
//        } else {
//            hight = 330
//        }
        return CGSize(width: Int(view.frame.width) - 40, height: hight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    
    
}

func newView() {
//    let vc = PersonalData()
//    navigationController?.pushViewController(vc, animated: true)
}
