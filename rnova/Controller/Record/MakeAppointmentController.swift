//
//  MakeAppointmentController.swift
//  rnova
//
//  Created by Александр Меренков on 11/8/21.
//

import UIKit

protocol SendCommentProtocol {
    func gettingComment() -> String?
}

final class MakeAppointmentController: UIViewController {
    
//    MARK: - Properties
    
    private let doctor: Doctor
    private let selectedDate: Date
    private let selectedTime: String
    
    var delegateComment: SendCommentProtocol?
        
    private let databaseService = DatabaseService()
    
    private let datePicker = UIDatePicker()
    private let formatter = DateFormatter()
    
    private let recordInformationView = RecordInformationView()
    private let contactInformationView = ContactInformationView()
    
    private let submitButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowRadius = 4
        btn.layer.masksToBounds = false
        btn.backgroundColor = .systemOrange
        btn.setTitle("Записаться", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
//    MARK: - Lifecycle
    
    init(doctor: Doctor, selectedDate: Date, selectedTime: String) {
        self.doctor = doctor
        self.selectedDate = selectedDate
        self.selectedTime = selectedTime
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Личные данные"
        configureUI()
        configureDatePicker()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        configureRecordInformationView()
        configureContactInformationView()
        configureSubmitButton()
    }
    
    private func configureRecordInformationView() {
        view.addSubview(recordInformationView)
        recordInformationView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingLeft: 10, paddingTop: 20, paddingRight: -10, height: 140)
        formatter.dateFormat = "dd.MM.yy"
        let date = selectedTime + " " + formatter.string(from: selectedDate)
        recordInformationView.setInformation(doctor, date: date)
    }
    
    private func configureContactInformationView() {
        view.addSubview(contactInformationView)
        delegateComment = contactInformationView
        contactInformationView.anchor(left: view.leftAnchor, top: recordInformationView.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingTop: 30, paddingRight: -10, height: 320)
 
        if databaseService.checkLogIn() {
            let user = databaseService.getPersonInformation()
            contactInformationView.lastNameField.text = user.lastname
            contactInformationView.firstNameField.text = user.firstname
            contactInformationView.surnameField.text = user.surname
            contactInformationView.dateField.text = String(user.date)
            contactInformationView.phoneNumberField.text = user.phoneNumber
        }
    }
    
    private func configureSubmitButton() {
        view.addSubview(submitButton)
        submitButton.anchor(left: view.leftAnchor, top: contactInformationView.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingTop: 30, paddingRight: -10, height: 60)
        submitButton.addTarget(self, action: #selector(saveTicket), for: .touchUpInside)
    }
    
    private func configureDatePicker() {
        contactInformationView.dateField.inputView = datePicker
        datePicker.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        contactInformationView.dateField.inputAccessoryView = toolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
        _ = UITapGestureRecognizer(target: self, action: #selector(cancelAction))
    }
    
//    MARK: - Selectors
    
    @objc private func doneAction() {
        formatter.dateFormat = "dd.MM.yyyy"
        contactInformationView.dateField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func cancelAction() {
        view.endEditing(true)
    }
    
    @objc private func saveTicket() {
        if databaseService.checkLogIn() {
            let clinic = "Моя клиника"
            let comment = delegateComment?.gettingComment()
            var fullComment: String
            if comment == nil {
                fullComment = ""
            } else {
                fullComment = comment!
            }
            let ticket = Appointment(doctor: doctor.name, profession: doctor.profession_titles, time: selectedTime, date: selectedDate, clinic: clinic, comment: fullComment)
            databaseService.saveDoctorAppointment(ticket: ticket)
            let alert = UIAlertController(title: "Уведомление", message: "Поздравляем, вы успешно записались", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Внимание", message: "Предварительно необходимо зарегистрироваться.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
