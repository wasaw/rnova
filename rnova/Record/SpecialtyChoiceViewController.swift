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
    private var doctorsData = [Doctors]()
    private var professionsData = [Professions]()
    private var scheduleData = [String: [Schedule]]()
    private var arrDoctorId: [Int] = []
    private var arrTimeForDoctor: [String] = []
    private var arrAllTime: [[String]] = []
    private let labelTitle = UILabel()
    private var timeButtons: [UIButton] = []
    
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
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
            self.professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
            self.scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: "").scheduleData
            countingDoctorInformation()
            getSpecialty()
            activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
        }

        func countingDoctorInformation() {
            let dateFormat = Date()
            let format = DateFormatter()
            format.dateFormat = "dd.MM.yyyy"
            let nowDay = format.string(from: dateFormat)
//            let nowDay = "08.09.2021"
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
        
        func getSpecialty() {
            for item in 0...professionsData.count - 1 {
                if professionsData[item].id == id {
                    labelTitle.text = professionsData[item].name
                    break
                }else {
                    labelTitle.text = "Название специальности"
                }
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
        for i in 0..<doctorsData.count {
            if doctorsData[i].id == arrDoctorId[indexPath.row] && doctorsData[i].avatar_small != nil {
                cell.doctorImageView.downloaded(from: doctorsData[i].avatar_small!)
            }
        }
        
//        if arrAllTime[indexPath.row].count > 0 {
//            createButton(for: arrAllTime[indexPath.row].count, arrTime: arrAllTime[indexPath.row], indexPath: indexPath.row)
//        }else {
//            cell.labelNoTime.isHidden = false
//        }
        cell.labelNoTime.isHidden = false
        return cell
    }
    
//    func createButton(for end: Int, arrTime: [String], indexPath: Int) {
//        var countX = 0
//        var countY = 0
//        var multiplier = 1
//        var stop: Int
//        stop = end - 1
//        if stop > 7 {
//            stop = 7
//        }
//        let startPudding = 25
//        let padding = 95
////        var y:CGFloat = 310 * CGFloat(indexPath + 1) + CGFloat(indexPath * 10)
//        let y:CGFloat = 310 * CGFloat(indexPath + 1)
//        let yPadding = 50
//        let width: CGFloat = 90
//        let height: CGFloat = 35
//        let divisor = 3
//        for item in 0...stop {
//            let button = UIButton(type: .system)
//            button.setTitle(arrTime[item], for: .normal)
//            button.backgroundColor = UIColor.systemOrange
//            button.tintColor = .black
//            button.layer.cornerRadius = 18
//            button.clipsToBounds = true
//            button.tag = indexPath * 100 + item
//            button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
//
//            if countY ==  (divisor + 1) {
//                countY = 0
//                multiplier += 1
//            }
//            if countX == (divisor + 1) {
//                countX = 0
//            }
//
//            button.frame = CGRect(x: CGFloat(startPudding + padding * countX), y: (y + CGFloat(yPadding * multiplier)), width: width, height: height)
//            countX += 1
//            countY += 1
//            view.addSubview(button)
//        }
//    }
//
//    @objc func buttonTap(sender: UIButton) {
//        let dateFormat = Date()
//        let formatDay = DateFormatter()
//        formatDay.dateFormat = "dd.MM.yyyy"
//        let nowDay = formatDay.string(from: dateFormat)
//        let doctorTime = nowDay + " " + arrAllTime[sender.tag / 100][sender.tag % 100]
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd.MM.yyyy HH:mm"
//        guard let time = formatter.date(from: doctorTime) else { return  }
//        let vc = EnteringInformation(id: arrDoctorId[sender.tag / 100], name: arrDoctorName[sender.tag / 100], time: time)
//        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let lineCount = CGFloat(arrAllTime[indexPath.row].count) / 4
        let lineCount = CGFloat(1)
        let counter = 50
        let hight = 190 + counter * Int(lineCount.rounded(.up))
        return CGSize(width: Int(view.frame.width) - 40, height: hight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    
    
}

