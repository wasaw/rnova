//
//  DataRecordChoiceController.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

class DateRecordChoiceController: UIViewController {
    
    private let doctorId: Int
    private let doctor: Doctor
    private var scheduleData = [String: [Schedule]]()
    private let insents = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private let dayNames = [0 : "Пн", 1 : "Вт", 2 : "Ср", 3 : "Чт", 4 : "Пт", 5 : "Сб", 6 : "Вс"]
    private let formatter = DateFormatter()
    private var calendarDayCounter = 0
    private var currentDay = Date()
    private var timeStartArray = [String]()
    private var calendarTwoWeekDay = [Date]()
    private var selectedDay = 0
    
    private let doctorInfoView = DoctorInformationView()
    private let choiceDateView = ChoiceDateView()
        
    private var dateCollectionView: UICollectionView
    private var timeCollectionView: UICollectionView
    
    private let choiceTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать время:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    private let noFreeTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет свободного времени"
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    init(doctor: Doctor) {
        self.doctor = doctor
        self.doctorId = doctor.id
        self.dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.timeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор времени"
        
        configureUI()
        setValue()
        
        let urlStr = "&user_id=" + String(self.doctorId)
        DispatchQueue.main.async {
            self.scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: urlStr).scheduleData
            if !self.scheduleData.isEmpty {
                self.setTimeCollectionView()
            }
        }
        
        configureDate()
        
        view.backgroundColor = .white
    }
    
//    MARK: -- Function
    
    func configureUI() {
        configureDoctorView()
        configureDateCollectionView()
        configureChoiceTimeLabel()
        configureTimeCollectionView()
        configureNoFreeTimeLabel()
    }
    
    func configureDoctorView() {
        view.addSubview(doctorInfoView)
        view.addSubview(choiceDateView)
        
        doctorInfoView.translatesAutoresizingMaskIntoConstraints = false
        doctorInfoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive  = true
        doctorInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        doctorInfoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        doctorInfoView.heightAnchor.constraint(equalToConstant: view.frame.width / 4).isActive = true
        doctorInfoView.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        
        choiceDateView.translatesAutoresizingMaskIntoConstraints = false
        choiceDateView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        choiceDateView.topAnchor.constraint(equalTo: doctorInfoView.bottomAnchor, constant: 30).isActive = true
        choiceDateView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        choiceDateView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func configureDateCollectionView() {
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(UINib(nibName: CalendarViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: CalendarViewCell.identifire)
        
        view.addSubview(dateCollectionView)
        
        dateCollectionView.translatesAutoresizingMaskIntoConstraints = false
        dateCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        dateCollectionView.topAnchor.constraint(equalTo: choiceDateView.bottomAnchor, constant: 30).isActive = true
        dateCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        dateCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    func configureChoiceTimeLabel() {
        view.addSubview(choiceTimeLabel)
        
        choiceTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        choiceTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        choiceTimeLabel.topAnchor.constraint(equalTo: dateCollectionView.bottomAnchor, constant: 20).isActive = true
        choiceTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func configureTimeCollectionView() {
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.register(UINib(nibName: TimeViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: TimeViewCell.identifire)
        
        view.addSubview(timeCollectionView)
        
        timeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        timeCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        timeCollectionView.topAnchor.constraint(equalTo: choiceTimeLabel.bottomAnchor, constant: 30).isActive = true
        timeCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        timeCollectionView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }
    
    func configureNoFreeTimeLabel() {
        view.addSubview(noFreeTimeLabel)
        
        noFreeTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        noFreeTimeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        noFreeTimeLabel.topAnchor.constraint(equalTo: choiceTimeLabel.bottomAnchor, constant: 20).isActive = true
        noFreeTimeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        noFreeTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        noFreeTimeLabel.isHidden = false
    }
    
    func configureDate() {
        let dayOfWeek = Calendar.current.component(.weekday, from: currentDay)

        switch dayOfWeek {
        case 1:
            calendarDayCounter = 1
        case 3:
            calendarDayCounter = -1
            selectedDay = 1
        case 4:
            calendarDayCounter = -2
            selectedDay = 2
        case 5:
            calendarDayCounter = -3
            selectedDay = 3
        case 6:
            calendarDayCounter = -4
            selectedDay = 4
        case 7:
            calendarDayCounter = -5
            selectedDay = 5
        default:
            calendarDayCounter = 0
        }
        
        setDateDurationLabel()
        calendarTwoWeekDay = []
        for _ in 0...13 {
            let day = Calendar.current.date(byAdding: .day, value: calendarDayCounter, to: currentDay)
            guard let day = day else { continue }
            calendarTwoWeekDay.append(day)
            calendarDayCounter += 1
        }
    }
    
    func setDateDurationLabel() {
        let firstDay = Calendar.current.date(byAdding: .day, value: calendarDayCounter, to: currentDay)
        let lastDay = Calendar.current.date(byAdding: .day, value: calendarDayCounter + 13, to: currentDay)
        formatter.dateFormat = "dd MMMM"
        guard let firstDay = firstDay else { return }
        guard let lastDay = lastDay else { return }
        choiceDateView.dateDurationLabel.text = formatter.string(from: firstDay) + " - " + formatter.string(from: lastDay)
    }
    
    func setTimeCollectionView() {
        guard let scheduleTimeArr = scheduleData[String(doctorId)] else { return }
        formatter.dateFormat = "dd.MM.yyyy"
        let choiceDay = formatter.string(from: calendarTwoWeekDay[selectedDay])
        timeStartArray = []
        for item in scheduleTimeArr {
            if choiceDay == item.date {
                timeStartArray.append(item.time_start_short)
            }
        }
        if timeStartArray.isEmpty {
            noFreeTimeLabel.isHidden = false
        } else {
            noFreeTimeLabel.isHidden = true
        }
        timeCollectionView.reloadData()
    }
    
    func setValue() {
        doctorInfoView.surnameLabel.text = doctor.name
        doctorInfoView.professionLabel.text = doctor.profession_titles
        doctorInfoView.profileImageView.image = doctor.image.image
    }
    
    @objc func pressLeftButton() {
        //2 week
        currentDay = currentDay.addingTimeInterval(-1209600)
        configureDate()
        dateCollectionView.reloadData()
    }
    
    @objc func pressRightButton() {
        //2 week
        currentDay = currentDay.addingTimeInterval(1209600)
        configureDate()
        dateCollectionView.reloadData()
    }
}

// MARK: -- extension
extension DateRecordChoiceController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.dateCollectionView {
            selectedDay = indexPath.row - 7
            dateCollectionView.reloadData()
            setTimeCollectionView()
        } else {
            let vc = MakeAppointmentController(doctor: doctor, selectedDate: calendarTwoWeekDay[selectedDay], selectedTime: timeStartArray[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DateRecordChoiceController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.dateCollectionView {
            return 21
        } else {
            return timeStartArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.dateCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewCell.identifire, for: indexPath) as? CalendarViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .white
            if indexPath.row < 7 {
                cell.label.text = dayNames[indexPath.row]
            } else {
                formatter.dateFormat = "dd"
                let stringDay = formatter.string(from: calendarTwoWeekDay[indexPath.row - 7])
                cell.label.text = stringDay
                if indexPath.row - 7 == selectedDay{
                    cell.backgroundColor = .systemOrange
                    cell.layer.cornerRadius = cell.frame.width / 2
                }
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeViewCell.identifire, for: indexPath) as? TimeViewCell else { return UICollectionViewCell() }
            cell.backgroundColor = .systemOrange
            cell.layer.cornerRadius = 15
            cell.label.text = timeStartArray[indexPath.row]
            return cell
        }
    }
}

extension DateRecordChoiceController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.dateCollectionView {
            let width = CGFloat(collectionView.frame.width / 7 - 12)
            let height = width
            return CGSize(width: width, height: height)
        } else {
            let width = CGFloat(collectionView.frame.width / 4 - 15)
            let heigt = CGFloat(40)
            return CGSize(width: width, height: heigt)
        }
    }
}
