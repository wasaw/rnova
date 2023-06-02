//
//  DataRecordChoiceController.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

private enum Constants {
    static let doctorInfoViewHorizontalPaddings: CGFloat = 10
    static let doctorInfoViewPaddingTop: CGFloat = 20
    static let choiceDateViewHorizontalPaddings: CGFloat = 10
    static let choiceDateViewPaddingTop: CGFloat = 30
    static let choiceDateViewHeight: CGFloat = 120
    static let dateCollectionHorizontalPaddings: CGFloat = 10
    static let dateCollectionPaddingTop: CGFloat = 30
    static let dateCollectionHeight: CGFloat = 170
    static let choiceTimeLabelHorizontalPaddings: CGFloat = 10
    static let choiceTimeLabelPaddingTop: CGFloat = 20
    static let timeCollectionHorizontalPaddings: CGFloat = 10
    static let timeCollectionPaddingTop: CGFloat = 30
    static let timeCollectionHeight: CGFloat = 170
    static let noFreeTimeLabelHorizontalPaddings: CGFloat = 10
    static let noFreeTimeLabelPaddingTop: CGFloat = 20
    static let noFreeTimeLabelHeight: CGFloat = 30
}

final class DateRecordChoiceController: UIViewController {
    
//    MARK: - Properties
    
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
        
    private var dateCollectionView: UICollectionView?
    private var timeCollectionView: UICollectionView?
    
    private lazy var choiceTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать время:"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    private lazy var noFreeTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет свободного времени"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    
//    MARK: - Lifecycle
    
    init(doctor: Doctor) {
        self.doctor = doctor
        self.doctorId = doctor.id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор времени"
        choiceDateView.delegate = self
        loadInformation()
        configureUI()
        setValue()
        configureDate()
        view.backgroundColor = .white
    }
    
//    MARK: - Functions
    
    private func loadInformation() {
        DispatchQueue.main.async {
            NetworkService.shared.request(method: .schedule) { (result: RequestStatus<[String: [Schedule]]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    self.scheduleData = answer
                    if !self.scheduleData.isEmpty {
                        self.setTimeCollectionView()
                    }
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
        }
    }
    
    private func configureUI() {
        configureDoctorView()
        configureDateCollectionView()
        configureChoiceTimeLabel()
        configureTimeCollectionView()
        configureNoFreeTimeLabel()
    }
    
    private func configureDoctorView() {
        view.addSubview(doctorInfoView)
        view.addSubview(choiceDateView)
        doctorInfoView.anchor(leading: view.leadingAnchor,
                              top: view.safeAreaLayoutGuide.topAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: Constants.doctorInfoViewHorizontalPaddings,
                              paddingTop: Constants.doctorInfoViewPaddingTop,
                              paddingTrailing: -Constants.doctorInfoViewHorizontalPaddings,
                              width: view.frame.width - 20,
                              height: view.frame.width / 4)
        
        choiceDateView.anchor(leading: view.leadingAnchor,
                              top: doctorInfoView.bottomAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: Constants.choiceDateViewHorizontalPaddings,
                              paddingTop: Constants.choiceDateViewPaddingTop,
                              paddingTrailing: -Constants.choiceDateViewHorizontalPaddings,
                              height: Constants.choiceDateViewHeight)
    }
    
    private func configureDateCollectionView() {
        dateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let dateCollectionView = dateCollectionView else { return }
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        dateCollectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifire)
        
        view.addSubview(dateCollectionView)
        dateCollectionView.anchor(leading: view.leadingAnchor,
                                  top: choiceDateView.bottomAnchor,
                                  trailing: view.trailingAnchor,
                                  paddingLeading: Constants.dateCollectionHorizontalPaddings,
                                  paddingTop: Constants.dateCollectionPaddingTop,
                                  paddingTrailing: -Constants.dateCollectionHorizontalPaddings,
                                  height: Constants.dateCollectionHeight)
        dateCollectionView.backgroundColor = .white
    }
    
    private func configureChoiceTimeLabel() {
        view.addSubview(choiceTimeLabel)
        choiceTimeLabel.anchor(leading: view.leadingAnchor,
                               top: dateCollectionView?.bottomAnchor,
                               trailing: view.trailingAnchor,
                               paddingLeading: Constants.choiceTimeLabelHorizontalPaddings,
                               paddingTop: Constants.choiceTimeLabelPaddingTop,
                               paddingTrailing: -Constants.choiceTimeLabelHorizontalPaddings)
    }
    
    private func configureTimeCollectionView() {
        timeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let timeCollectionView = timeCollectionView else { return }
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        timeCollectionView.register(TimeViewCell.self, forCellWithReuseIdentifier: TimeViewCell.identifire)
        
        view.addSubview(timeCollectionView)
        timeCollectionView.anchor(leading: view.leadingAnchor,
                                  top: choiceTimeLabel.bottomAnchor,
                                  trailing: view.trailingAnchor,
                                  paddingLeading: Constants.timeCollectionHorizontalPaddings,
                                  paddingTop: Constants.timeCollectionPaddingTop,
                                  paddingTrailing: -Constants.timeCollectionHorizontalPaddings,
                                  height: Constants.timeCollectionHeight)
        timeCollectionView.backgroundColor = .white
    }
    
    private func configureNoFreeTimeLabel() {
        view.addSubview(noFreeTimeLabel)
        noFreeTimeLabel.anchor(leading: view.leadingAnchor,
                               top: choiceTimeLabel.bottomAnchor,
                               trailing: view.trailingAnchor,
                               paddingLeading: Constants.noFreeTimeLabelHorizontalPaddings,
                               paddingTop: Constants.noFreeTimeLabelPaddingTop,
                               paddingTrailing: -Constants.noFreeTimeLabelHorizontalPaddings,
                               height: Constants.noFreeTimeLabelHeight)
        noFreeTimeLabel.isHidden = false
    }
    
    private func configureDate() {
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
    
    private func setDateDurationLabel() {
        let firstDay = Calendar.current.date(byAdding: .day, value: calendarDayCounter, to: currentDay)
        let lastDay = Calendar.current.date(byAdding: .day, value: calendarDayCounter + 13, to: currentDay)
        formatter.dateFormat = "dd MMMM"
        guard let firstDay = firstDay else { return }
        guard let lastDay = lastDay else { return }
        choiceDateView.setInformation(firstDay: formatter.string(from: firstDay), lastDay: formatter.string(from: lastDay))
    }
    
    private func setTimeCollectionView() {
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
        timeCollectionView?.reloadData()
    }
    
    private func setValue() {
        doctorInfoView.setInformation(doctor)
    }
}

// MARK: - Extensions

extension DateRecordChoiceController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.dateCollectionView {
            selectedDay = indexPath.row - 7
            dateCollectionView?.reloadData()
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
            cell.resetDate()
            if indexPath.row < 7 {
                if let dayName = dayNames[indexPath.row] {
                    cell.setInformation(dayName)
                }
            } else {
                formatter.dateFormat = "dd"
                let stringDay = formatter.string(from: calendarTwoWeekDay[indexPath.row - 7])
                cell.setInformation(stringDay)
                if indexPath.row - 7 == selectedDay{
                    cell.selectDate()
                    cell.layer.cornerRadius = cell.frame.width / 2
                }
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeViewCell.identifire, for: indexPath) as? TimeViewCell else { return UICollectionViewCell() }
            cell.setInformation(timeStartArray[indexPath.row])
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

extension DateRecordChoiceController: FlipCalendarDelegate {
    func flipCalendar(direction: FlipCalendar) {
        //2 week
        switch direction {
        case .left:
            currentDay = currentDay.addingTimeInterval(-1209600)
        case .right:
            currentDay = currentDay.addingTimeInterval(1209600)
        }
        configureDate()
        dateCollectionView?.reloadData()
    }
}
