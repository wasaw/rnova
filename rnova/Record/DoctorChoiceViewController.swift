//
//  DoctorChoiceViewController.swift
//  rnova
//
//  Created by Александр Меренков on 3/2/21.
//

import UIKit

class DoctorChoiceViewController: UIViewController {
    
    let doctorId: Int
    let clinicId: Int
    let datePicker = UIDatePicker()
    let textFieldDate = UITextField(frame: CGRect(x: 80, y: 250, width: 250, height: 40))
    var dateChoise = Date.init()

    
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
//        let urlParemeter = "&clinic_id=" + String(clinicId)
//        let professionData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlParemeter).doctorsData
//
        let urlStr = "&user_id=" + String(self.doctorId)
        let doctorData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlStr).doctorsData
        
        let labelName = UILabel(frame: CGRect(x: 20, y: 140, width: widthLabel, height: 60))
        labelName.font = UIFont.boldSystemFont(ofSize: 32)
        labelName.textAlignment = .center
        labelName.text = String(doctorData[0].name)
        labelName.textColor = .black
        view.addSubview(labelName)
        
        let labelTextData = UILabel(frame: CGRect(x: 20, y: 200, width: widthLabel, height: 40))
        labelTextData.font = UIFont.boldSystemFont(ofSize: 18)
        labelTextData.textAlignment = .left
        labelTextData.text = "Выбрать дату:"
        labelTextData.textColor = .black
        view.addSubview(labelTextData)
        
        textFieldDate.layer.borderWidth = 1
        textFieldDate.textAlignment = .center
        textFieldDate.textColor = .black

        let formatterDate = DateFormatter()
        formatterDate.dateFormat = .none
        formatterDate.dateStyle = .medium
        textFieldDate.text = formatterDate.string(from: datePicker.date)
        view.addSubview(textFieldDate)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePress))
        toolbar.setItems([doneBtn], animated: true)
        textFieldDate.inputAccessoryView = toolbar
        textFieldDate.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let buttonLeft = UIButton(frame: CGRect(x: 20, y: 250, width: 40, height: 40))
        buttonLeft.tintColor = UIColor.systemOrange
        buttonLeft.layer.borderWidth = 1
        buttonLeft.layer.borderColor = UIColor.systemOrange.cgColor
        let imgLeft = UIImage(systemName: "chevron.left")
        buttonLeft.setImage(imgLeft, for: .normal)
        buttonLeft.addTarget(self, action: #selector(pressLeftButton), for: .touchUpInside)
        view.addSubview(buttonLeft)
        
        let buttonRight = UIButton(frame: CGRect(x: 350, y: 250, width: 40, height: 40))
        buttonRight.tintColor = UIColor.systemOrange
        buttonRight.layer.borderWidth = 1
        buttonRight.layer.borderColor = UIColor.systemOrange.cgColor
        let imgRight = UIImage(systemName: "chevron.right")
        buttonRight.setImage(imgRight, for: .normal)
        buttonRight.addTarget(self, action: #selector(pressRightButton), for: .touchUpInside)
        view.addSubview(buttonRight)
        
        let labelTime = UILabel(frame: CGRect(x: 20, y: 310, width: widthLabel, height: 40))
        labelTime.font = UIFont.boldSystemFont(ofSize: 18)
        labelTime.textAlignment = .left
        labelTime.text = "Выбрать время:"
        labelTime.textColor = .black
        view.addSubview(labelTime)
        
        let labelTimeText = UILabel(frame: CGRect(x: 20, y: 350, width: widthLabel, height: 40))
        labelTimeText.font = UIFont.systemFont(ofSize: 14)
        labelTimeText.textAlignment = .left
        labelTimeText.text = "Нет свободного времени"
        labelTimeText.textColor = .black
        view.addSubview(labelTimeText)
        
        view.backgroundColor = .white
        
    }

    @objc func pressLeftButton(sender: UIButton!) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateChoise.addTimeInterval(-86400)
        textFieldDate.text = formatter.string(from: dateChoise)
    }
    
    @objc func pressRightButton(sender: UIButton!) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateChoise.addTimeInterval(86400)
        textFieldDate.text = formatter.string(from: dateChoise)
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
    
}

