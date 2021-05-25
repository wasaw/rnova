//
//  DoctorChoiceViewController.swift
//  rnova
//
//  Created by Александр Меренков on 3/2/21.
//

import UIKit
import FSCalendar

class DoctorChoiceViewController: UIViewController {
        
    
    let doctorId: Int
    let clinicId: Int
    let datePicker = UIDatePicker()
    let textFieldDate = UITextField(frame: CGRect(x: 80, y: 270, width: 250, height: 40))
    var dateChoise = Date.init()
    var calendar: FSCalendar!
    let dataFormat = Date()
    var formatter = DateFormatter()
    var formatterWeek = DateFormatter()
    var scheduleData = DataLoader(urlMethod: "&method=getSchedule", urlParameter: "").scheduleData
    var arrTimeForDoctor: [String] = []
    var timeButtons: [UIButton] = []
    let monthName = [1: "january", 2: "february", 3: "march", 4: "april", 5: "may", 6: "june", 7: "july", 8: "august", 9: "september", 10: "october", 11: "november", 12: "december"]
    
    private var startDate = Date()
    private var startWeekMonth = Int()
    private var endDate = Date()
    private var endWeekMonth = Int()
    let myCalendar = Calendar(identifier: .gregorian)

    let labelTimeText = UILabel()
    
    init(id: Int, clinicId: Int) {
        self.doctorId = id
        self.clinicId = clinicId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.bounds.width
        let widthLabel = width - 40
        formatter.dateFormat = "dd.MM.yyyy"
        var nowDay = formatter.string(from: dataFormat)
//        var nowDay = "24.05.2021"
        let weekDay = myCalendar.component(.weekday, from: formatter.date(from: nowDay)!)

        
//        print(weekMonth)
//        var nowDay = "19.05.2021"
        if let strTime = scheduleData[String(doctorId)] {
            for i in 0...strTime.count - 1 {
                if nowDay == strTime[i].date {
                    arrTimeForDoctor.append(strTime[i].time_start_short)
//                    print(arrTimeForDoctor.count)
                }
            }
        } else {
            print("DEBUG: not found")
        }
        

        
        
        
        
        
//        let urlParemeter = "&clinic_id=" + String(clinicId)
//        let professionData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlParemeter).doctorsData
//
        let urlStr = "&user_id=" + String(self.doctorId)
        let doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlStr).doctorsData
        
        let textView = UITextView()
        textView.frame = CGRect(x: 20, y: 120, width: view.frame.width - 40, height: 80)
        textView.layer.cornerRadius = 10
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.shadowOpacity = 1
        textView.layer.shadowRadius = 1.0
        textView.clipsToBounds = false
        textView.layer.masksToBounds = false
        view.addSubview(textView)
        
        let profileImageView = UIImageView()
        let profileImage = UIImage(systemName: "person")
        profileImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        profileImageView.image = profileImage
        textView.addSubview(profileImageView)
        
        
        let labelName = UILabel(frame: CGRect(x: 50, y: 20, width: textView.frame.width - 60, height: 30))
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.textAlignment = .center
        labelName.text = String(doctorData[0].name)
        labelName.textColor = .black
        textView.addSubview(labelName)
        
        let labelTextData = UILabel(frame: CGRect(x: 20, y: 220, width: widthLabel, height: 40))
        labelTextData.font = UIFont.boldSystemFont(ofSize: 18)
        labelTextData.textAlignment = .left
        labelTextData.text = "Выбрать дату:"
        labelTextData.textColor = .black
        view.addSubview(labelTextData)
        
        

//        let formatterDate = DateFormatter()
//        formatterDate.dateFormat = .none
//        formatterDate.dateStyle = .medium
//        textFieldDate.text = formatterDate.string(from: datePicker.date)
//        view.addSubview(textFieldDate)
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
        
//        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePress))
//        toolbar.setItems([doneBtn], animated: true)
//        textFieldDate.inputAccessoryView = toolbar
//        textFieldDate.inputView = datePicker
//        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .wheels
        
        let buttonLeft = UIButton(frame: CGRect(x: 20, y: 270, width: 40, height: 40))
        buttonLeft.tintColor = UIColor.systemOrange
        buttonLeft.layer.borderWidth = 1
        buttonLeft.layer.borderColor = UIColor.systemOrange.cgColor
        let imgLeft = UIImage(systemName: "chevron.left")
        buttonLeft.setImage(imgLeft, for: .normal)
        buttonLeft.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
        view.addSubview(buttonLeft)
        
        let buttonRight = UIButton(frame: CGRect(x: 350, y: 270, width: 40, height: 40))
        buttonRight.tintColor = UIColor.systemOrange
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor.systemOrange.cgColor
        let imgRight = UIImage(systemName: "chevron.right")
        buttonRight.setImage(imgRight, for: .normal)
        buttonRight.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
        view.addSubview(buttonRight)
        
        
        calendar = FSCalendar(frame: CGRect(x: 20, y: 330, width: widthLabel, height: 250))
        calendar.scrollDirection = .horizontal
        calendar.scope = .week
        calendar.firstWeekday = 2
        calendar.delegate = self
        calendar.appearance.todayColor = .systemOrange
        calendar.appearance.selectionColor = .systemOrange
        calendar.appearance.headerDateFormat = .none
        calendar.scrollEnabled = false
        view.addSubview(calendar)
        
        
        if let todayDate = calendar.today {
            formatterWeek.dateFormat = "dd"
            startDate = todayDate.addingTimeInterval(TimeInterval(-86400 * (weekDay - 2)))
            startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
            endDate = todayDate.addingTimeInterval(TimeInterval(86400 * (8 - weekDay)))
            endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
            textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
        } else {
            textFieldDate.text = ""
        }
        
        textFieldDate.textAlignment = .center
        textFieldDate.textColor = .black
        view.addSubview(textFieldDate)
    
        createButton(timeArr: arrTimeForDoctor)
        
        
        let labelTime = UILabel(frame: CGRect(x: 20, y: 430, width: widthLabel, height: 40))
        labelTime.font = UIFont.boldSystemFont(ofSize: 18)
        labelTime.textAlignment = .left
        labelTime.text = "Выбрать время:"
        labelTime.textColor = .black
        view.addSubview(labelTime)
        
        
        labelTimeText.frame = CGRect(x: 20, y: 470, width: widthLabel, height: 40)
        labelTimeText.font = UIFont.systemFont(ofSize: 14)
        labelTimeText.textAlignment = .left
        labelTimeText.text = "Нет свободного времени"
        labelTimeText.textColor = .black
        labelTimeText.isHidden = true
        view.addSubview(labelTimeText)
        if arrTimeForDoctor.count != 0 {
            labelTimeText.isHidden = true
        } else {
            labelTimeText.isHidden = false
        }

      
        
        view.backgroundColor = .white
        
    }

    @objc func pressLeftButton(sender: UIButton!) {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        print("DEBUG: Left button")
//        dateChoise.addTimeInterval(-86400)
//        textFieldDate.text = formatter.string(from: dateChoise)
        
        formatterWeek.dateFormat = "dd"
        startDate = startDate.addingTimeInterval(TimeInterval(-86400 * 7))
        startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
        endDate = endDate.addingTimeInterval(TimeInterval(-86400 * 7))
        endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
        textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
        calendar.setCurrentPage(startDate, animated: true)
    }
    
    @objc func pressRightButton(sender: UIButton!) {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        print("DEBUG: Right button")
//        dateChoise.addTimeInterval(86400)
//        textFieldDate.text = formatter.string(from: dateChoise)
        
        formatterWeek.dateFormat = "dd"
        startDate = startDate.addingTimeInterval(TimeInterval(86400 * 7))
        startWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: startDate))!)
        endDate = endDate.addingTimeInterval(TimeInterval(86400 * 7))
        endWeekMonth = myCalendar.component(.month, from: formatter.date(from: formatter.string(from: endDate))!)
        textFieldDate.text = "\(formatterWeek.string(from: startDate)) \(monthName[startWeekMonth]!) - \(formatterWeek.string(from: endDate)) \(monthName[endWeekMonth]!)"
        calendar.setCurrentPage(startDate, animated: true)
    }
    
    @objc func donePress() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
//        var dateT = datePicker.date
//        dateT.addTimeInterval(86400)
//        textFieldDate.text = formatter.string(from: dateT)
        dateChoise = datePicker.date
        textFieldDate.text = formatter.string(from: dateChoise)
//        textFieldDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    

    
    
    func createButton(timeArr: [String]) {
        var countX = 0
        var countY = 0
        var multiplier = 1
        let divisor = 4
        let startPadding = 20
        let startY = 420
        let paddingX = 80
        let paddingY = 50
        if timeArr.count == 0 {
//            not time for record
        } else {
            for item in 0...timeArr.count - 1 {
                let button = UIButton(type: .system)
                button.setTitle(timeArr[item], for: .normal)
                button.layer.borderWidth = 1
                button.layer.backgroundColor = UIColor.black.cgColor
                button.backgroundColor = UIColor.systemOrange
                button.layer.cornerRadius = 15
                button.clipsToBounds = true
                button.tag = item
                button.addTarget(self, action: #selector(self.buttonTap), for: .touchUpInside)
                
                if countY == (divisor + 1) {
                    countY = 0
                    multiplier += 1
                }
                
                if countX == (divisor + 1) {
                    countX = 0
                }
                button.frame = CGRect(x: CGFloat(startPadding + paddingX * countX), y: CGFloat(startY + paddingY * multiplier), width: 70, height: 40)
                countX += 1
                countY += 1
                view.addSubview(button)
                timeButtons.append(button)
//                print("DEBUG: \(timeButtons.count)")
            }
        }
    }
    
    @objc func buttonTap(sender: UIButton) {
        print("Press button №\(sender.tag)")
    }
    
    
}

extension DoctorChoiceViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        formatter.dateFormat = "dd-MM-yyyy"
        timeButtons.forEach { $0.removeFromSuperview() }
        timeButtons.removeAll()
//        calendar.appearance.todayColor = .white
//        calendar.appearance.weekdayTextColor = .black
        calendar.today = nil
        
        formatter.dateFormat = "dd.MM.yyyy"
        arrTimeForDoctor = []
        let nowDay = formatter.string(from: date)
        if let strTime = scheduleData[String(doctorId)] {
            for i in 0...strTime.count - 1 {
                if nowDay == strTime[i].date {
                    arrTimeForDoctor.append(strTime[i].time_start_short)
//                    print(arrTimeForDoctor.count)
                }
            }
        } else {
            print("DEBUG: not found")
        }
        
        if arrTimeForDoctor.count != 0 {
            labelTimeText.isHidden = true
        } else {
            labelTimeText.isHidden = false
        }
        createButton(timeArr: arrTimeForDoctor)

    }
    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//
//
//
//    }
   
  
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
////        formatter.dateFormat = "dd-MM-yyyy"
//        guard let excludedDate = formatter.date(from: "26-05-2021") else { return true }
//        if date.compare(excludedDate) == .orderedSame {
//            return false
//        }
//        return true
//    }
}

//extension DoctorChoiceViewController: FSCalendarDataSource {
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("DEBUG: Change")
//    }
//}


