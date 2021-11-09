////
////  DoctorChoiceViewController.swift
////  rnova
////
////  Created by Александр Меренков on 3/2/21.
////
//
//import UIKit
//import FSCalendar
//
//class DoctorChoiceViewController: UIViewController {
//        
//    
//    private let doctorId: Int
//    private let datePicker = UIDatePicker()
//    private let textFieldDate = UITextField(frame: CGRect(x: 80, y: 270, width: 250, height: 40))
//    private var dateChoise = Date.init()
//    private var calendar: FSCalendar!
//    private let dataFormat = Date()
//    private var formatter = DateFormatter()
//    private var formatterWeek = DateFormatter()
//    private var scheduleData = [String: [Schedule]]()
//    private var arrTimeForDoctor: [Date] = []
//    private var timeButtons: [UIButton] = []
//    private let monthName = [1: "январь", 2: "февраль", 3: "март", 4: "апрель", 5: "май", 6: "июнь", 7: "июль", 8: "август", 9: "сентябрь", 10: "октябрь", 11: "ноябрь", 12: "декабрь"]
//    
//    private var startDate = Date()
//    private var startWeekMonth = Int()
//    private var endDate = Date()
//    private var endWeekMonth = Int()
//    private let myCalendar = Calendar(identifier: .gregorian)
//
//    private let labelTimeText = UILabel()
//    
//    private var recordTime: [Date]
//    
//    private var doctorData: [Doctors]
//    
//    init(id: Int) {
//        self.doctorId = id
//        self.recordTime = []
//        self.doctorData = []
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
//        activityIndicator.center = view.center
//        activityIndicator.startAnimating()
//        view.addSubview(activityIndicator)
//        let urlStr = "&user_id=" + String(self.doctorId)
//        DispatchQueue.main.async {
//            self.scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: "").scheduleData
//            self.doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlStr).doctorsData
//            self.calendar.reloadData()
//            activityIndicator.stopAnimating()
//        }
//        
//        let width = view.bounds.width
//        let widthLabel = width - 40
//        formatter.dateFormat = "dd.MM.yyyy"
//        let nowDay = formatter.string(from: dataFormat)
////        var nowDay = "24.05.2021"
//        let weekDay = myCalendar.component(.weekday, from: formatter.date(from: nowDay)!)
//        
//        if let strTime = scheduleData[String(doctorId)] {
//            for i in 0...strTime.count - 1 {
//                if nowDay == strTime[i].date {
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "dd.MM.yyyy HH:mm"
//                    let nowDayTimeShort = nowDay + " " + strTime[i].time_start_short
//                    guard let timeStartShort = formatter.date(from: nowDayTimeShort) else { return }
//                    arrTimeForDoctor.append(timeStartShort)
//                }
//            }
//        } else {
//            print("DEBUG: not found")
//        }
//        
////        let urlStr = "&user_id=" + String(self.doctorId)
//        doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlStr).doctorsData
//        
//        let textView = UITextView()
//        textView.frame = CGRect(x: 20, y: 120, width: view.frame.width - 40, height: 80)
//        textView.layer.cornerRadius = 10
//        textView.layer.shadowColor = UIColor.lightGray.cgColor
//        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        textView.layer.shadowOpacity = 0.3
//        textView.layer.shadowRadius = 4
//        textView.clipsToBounds = false
//        textView.layer.masksToBounds = false
//        textView.backgroundColor = .white
//        view.addSubview(textView)
//        
//        let profileImageView = UIImageView()
//        profileImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
//        profileImageView.layer.cornerRadius = 20
//        profileImageView.layer.masksToBounds = false
//        profileImageView.clipsToBounds = true
//        if doctorData[0].avatar_small != nil {
//            profileImageView.downloaded(from: doctorData[0].avatar_small!)
//        } else {
//            let profileImage = UIImage(systemName: "person")
//            profileImageView.image = profileImage
//        }
//        textView.addSubview(profileImageView)
//        
//        
//        let labelName = UILabel(frame: CGRect(x: 50, y: 20, width: textView.frame.width - 60, height: 30))
//        labelName.font = UIFont.boldSystemFont(ofSize: 20)
//        labelName.textAlignment = .center
//        labelName.text = String(doctorData[0].name)
//        labelName.textColor = .black
//        textView.addSubview(labelName)
//        
//        let labelTextData = UILabel(frame: CGRect(x: 20, y: 220, width: widthLabel, height: 40))
//        labelTextData.font = UIFont.boldSystemFont(ofSize: 18)
//        labelTextData.textAlignment = .left
//        labelTextData.text = "Выбрать дату:"
//        labelTextData.textColor = .black
//        view.addSubview(labelTextData)
//        
//        let buttonLeft = UIButton(frame: CGRect(x: 20, y: 270, width: 50, height: 50))
//        buttonLeft.tintColor = UIColor.systemOrange
//        buttonLeft.layer.borderWidth = 1
//        buttonLeft.layer.cornerRadius = 10
//        buttonLeft.layer.masksToBounds = false
//        buttonLeft.clipsToBounds = false
//        buttonLeft.layer.borderColor = UIColor.systemOrange.cgColor
//        let imgLeft = UIImage(systemName: "chevron.left")
//        buttonLeft.setImage(imgLeft, for: .normal)
//        buttonLeft.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
//        view.addSubview(buttonLeft)
//        
//        let buttonRight = UIButton(frame: CGRect(x: 350, y: 270, width: 50, height: 50))
//        buttonRight.tintColor = UIColor.systemOrange
//        buttonRight.layer.borderWidth = 1
//        buttonRight.layer.cornerRadius = 10
//        buttonRight.layer.masksToBounds = false
//        buttonRight.clipsToBounds = false
//        buttonRight.layer.borderColor = UIColor.systemOrange.cgColor
//        let imgRight = UIImage(systemName: "chevron.right")
//        buttonRight.setImage(imgRight, for: .normal)
//        buttonRight.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
//        view.addSubview(buttonRight)
//        
//        calendar = FSCalendar(frame: CGRect(x: 20, y: 310, width: widthLabel, height: 250))
//        calendar.scrollDirection = .horizontal
//        calendar.scope = .week
//        calendar.firstWeekday = 2
//        calendar.delegate = self
//        calendar.appearance.todayColor = .systemOrange
//        calendar.appearance.selectionColor = .systemOrange
//        calendar.appearance.headerDateFormat = .none
//        calendar.scrollEnabled = false
//        view.addSubview(calendar)
//        
//        if let todayDate = calendar.today {
//            formatterWeek.dateFormat = "dd"
//            startDate = todayDate.addingTimeInterval(TimeInterval(-86400 * (weekDay - 2)))
//            startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
//            endDate = todayDate.addingTimeInterval(TimeInterval(86400 * (8 - weekDay)))
//            endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
//            textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
//        } else {
//            textFieldDate.text = ""
//        }
//        
//        textFieldDate.textAlignment = .center
//        textFieldDate.textColor = .black
//        view.addSubview(textFieldDate)
//    
//        createButton(timeArr: arrTimeForDoctor)
//        
//        let labelTime = UILabel(frame: CGRect(x: 20, y: 430, width: widthLabel, height: 40))
//        labelTime.font = UIFont.boldSystemFont(ofSize: 18)
//        labelTime.textAlignment = .left
//        labelTime.text = "Выбрать время:"
//        labelTime.textColor = .black
//        view.addSubview(labelTime)
//        
//        labelTimeText.frame = CGRect(x: 20, y: 470, width: widthLabel, height: 40)
//        labelTimeText.font = UIFont.systemFont(ofSize: 14)
//        labelTimeText.textAlignment = .left
//        labelTimeText.text = "Нет свободного времени"
//        labelTimeText.textColor = .black
//        labelTimeText.isHidden = true
//        view.addSubview(labelTimeText)
//        if arrTimeForDoctor.count != 0 {
//            labelTimeText.isHidden = true
//        } else {
//            labelTimeText.isHidden = false
//        }
//        
//        navigationItem.title = "Выбор времени"
//        view.backgroundColor = .white
//    }
//
////    MARK: - Function
//    @objc func pressLeftButton(sender: UIButton!) {
//        formatterWeek.dateFormat = "dd"
//        startDate = startDate.addingTimeInterval(TimeInterval(-86400 * 7))
//        startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
//        endDate = endDate.addingTimeInterval(TimeInterval(-86400 * 7))
//        endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
//        textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
//        calendar.setCurrentPage(startDate, animated: true)
//    }
//    
//    @objc func pressRightButton(sender: UIButton!) {
//        formatterWeek.dateFormat = "dd"
//        startDate = startDate.addingTimeInterval(TimeInterval(86400 * 7))
//        startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
//        endDate = endDate.addingTimeInterval(TimeInterval(86400 * 7))
//        endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
//        textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
//        calendar.setCurrentPage(startDate, animated: true)
//    }
//    
//    func createButton(timeArr: [Date]) {
//        var countX = 0
//        var countY = 0
//        var multiplier = 1
//        let divisor = 3
//        let startPadding = 20
//        let startY = 420
//        let paddingX = 95
//        let paddingY = 50
//        recordTime = []
//        if timeArr.count == 0 {
////            not time for record
//            labelTimeText.isHidden = false
//        } else {
//            for item in 0...timeArr.count - 1 {
//                let button = UIButton(type: .system)
//                let formatter = DateFormatter()
//                formatter.dateFormat = "HH:mm"
//                let titleText = formatter.string(from: timeArr[item])
//                button.setTitle(titleText, for: .normal)
//                button.layer.backgroundColor = UIColor.black.cgColor
//                button.backgroundColor = UIColor.systemOrange
//                button.layer.cornerRadius = 18
//                button.clipsToBounds = true
//                button.tintColor = .black
//                recordTime.append(timeArr[item])
//                button.tag = item
//                button.addTarget(self, action: #selector(self.buttonTap), for: .touchUpInside)
//                
//                if countY == (divisor + 1) {
//                    countY = 0
//                    multiplier += 1
//                }
//                
//                if countX == (divisor + 1) {
//                    countX = 0
//                }
//                button.frame = CGRect(x: CGFloat(startPadding + paddingX * countX), y: CGFloat(startY + paddingY * multiplier), width: 90, height: 35)
//                countX += 1
//                countY += 1
//                view.addSubview(button)
//                timeButtons.append(button)
//            }
//        }
//    }
//    
//    @objc func buttonTap(sender: UIButton) {
//        let vc = EnteringInformation(id: doctorId, name: doctorData[0].name, time: recordTime[sender.tag])
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//}
//
//extension DoctorChoiceViewController: FSCalendarDelegate {
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        timeButtons.forEach { $0.removeFromSuperview() }
//        timeButtons.removeAll()
//        calendar.today = nil
//        formatter.dateFormat = "dd.MM.yyyy"
//        arrTimeForDoctor = []
//        let nowDay = formatter.string(from: date)
//        if let strTime = scheduleData[String(doctorId)] {
//            for i in 0...strTime.count - 1 {
//                if nowDay == strTime[i].date {
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "dd.MM.yyyy HH:mm"
//                    let nowDayTimeShort = nowDay + " " + strTime[i].time_start_short
//                    guard let strTime = formatter.date(from: nowDayTimeShort) else { return }
//                    arrTimeForDoctor.append(strTime)
//                }
//            }
//        } else {
//            print("DEBUG: not found")
//        }
//        
//        if arrTimeForDoctor.count != 0 {
//            labelTimeText.isHidden = true
//        } else {
//            labelTimeText.isHidden = false
//        }
//        createButton(timeArr: arrTimeForDoctor)
//    }
//    
//}
//
