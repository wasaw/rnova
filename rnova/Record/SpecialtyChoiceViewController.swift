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
    
    private var doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
    private var professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
    private let scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: "").scheduleData
    private var arrDoctorId: [Int] = []
    private var arrTimeForDoctor: [String] = []
    private var arrAllTime: [[String]] = []
    private let labelTitle = UILabel()
    
    var arrDoctorName: [String] = []
    var arrDoctorProfession: [String] = []
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormat = Date()
        let format = DateFormatter()
        format.dateFormat = "dd.MM.yyyy"
//        let nowDay = format.string(from: dateFormat)
        let nowDay = "18.06.2021"

        for item in 0...doctorsData.count - 1 {
//            can be more then one
            guard let str = doctorsData[item].profession else { continue }
            if str.count > 0 {
                for i in 0...str.count - 1 {
                    if id == Int(str[i]) {
                        arrDoctorId.append(doctorsData[item].id)
                        arrDoctorName.append(doctorsData[item].name)
                        guard let name = doctorsData[item].profession_titles else { continue }
                        arrDoctorProfession.append(name)
                        guard let strTime = scheduleData[String(doctorsData[item].id)] else {
                            arrTimeForDoctor = []
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
                            print("No free time")
                        }
                    }
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
    }
    
    //MARK: -collectionView parameters
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDoctorId.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialtyCollectionViewCell.identifier, for: indexPath) as? SpecialtyCollectionViewCell else { return UICollectionViewCell() }
        
        cell.labelDoctorName.text = arrDoctorName[indexPath.row]
        cell.labelProfession.text = arrDoctorProfession[indexPath.row]
        
        if arrAllTime[indexPath.row].count > 0 {
            cell.createButton(for: arrAllTime[indexPath.row].count, arrTime: arrAllTime[indexPath.row])
        }else {
            cell.createButton(for: 0, arrTime: [""])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineCount = CGFloat(arrAllTime[indexPath.row].count) / 4
        let counter = 50
        let hight = 180 + counter * Int(lineCount.rounded(.up))
        return CGSize(width: Int(view.frame.width) - 40, height: hight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    
    
}

