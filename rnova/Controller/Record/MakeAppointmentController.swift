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

class MakeAppointmentController: UIViewController {
    private let selectedDoctor: String
    private let selectedProfession: String
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
    
    init(selectedDoctor: String, selectedSpecialty: String, selectedDate: Date, selectedTime: String) {
        self.selectedDoctor = selectedDoctor
        self.selectedProfession = selectedSpecialty
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
    
//    MARK: -- function
    func configureUI() {
        configureRecordInformationView()
        configureContactInformationView()
        configureSubmitButton()
    }
    
    func configureRecordInformationView() {
        view.addSubview(recordInformationView)
        
        recordInformationView.translatesAutoresizingMaskIntoConstraints = false
        recordInformationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        recordInformationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        recordInformationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        recordInformationView.heightAnchor.constraint(equalToConstant: 140).isActive = true

        recordInformationView.doctorOutputLabel.text = selectedDoctor
        recordInformationView.professionOutputLabel.text = selectedProfession
        formatter.dateFormat = "dd.MM.yy"
        recordInformationView.dateOutputLabel.text = selectedTime + " " + formatter.string(from: selectedDate)
        recordInformationView.clinicOutputLable.text = "Моя клиника"
    }
    
    func configureContactInformationView() {
        view.addSubview(contactInformationView)
        delegateComment = contactInformationView
        contactInformationView.translatesAutoresizingMaskIntoConstraints = false
        contactInformationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        contactInformationView.topAnchor.constraint(equalTo: recordInformationView.bottomAnchor, constant: 30).isActive = true
        contactInformationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        contactInformationView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        if databaseService.checkLogIn() {
            let user = databaseService.getPersonInformation()
            contactInformationView.lastNameField.text = user.lastname
            contactInformationView.firstNameField.text = user.firstname
            contactInformationView.surnameField.text = user.surname
            contactInformationView.dateField.text = String(user.date)
            contactInformationView.phoneNumberField.text = user.phoneNumber
        }
    }
    
    func configureSubmitButton() {
        view.addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        submitButton.topAnchor.constraint(equalTo: contactInformationView.bottomAnchor,constant: 30).isActive = true
        submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        submitButton.addTarget(self, action: #selector(saveTicket), for: .touchUpInside)
    }
    
    func configureDatePicker() {
        contactInformationView.dateField.inputView = datePicker
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
    
    @objc func doneAction() {
        formatter.dateFormat = "dd.MM.yyyy"
        contactInformationView.dateField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc func cancelAction() {
        view.endEditing(true)
    }
    
    @objc func saveTicket() {
        if databaseService.checkLogIn() {
            guard let clinic = recordInformationView.clinicOutputLable.text else { return }
            let comment = delegateComment?.gettingComment()
            var fullComment: String
            if comment == nil {
                fullComment = ""
            } else {
                fullComment = comment!
            }
            let ticket = Appointment(doctor: selectedDoctor, profession: selectedProfession, time: selectedTime, date: selectedDate, clinic: clinic, comment: fullComment)
            databaseService.saveDoctorAppointment(ticket: ticket)
        } else {
            let alert = UIAlertController(title: "Внимание", message: "Предварительно необходимо зарегистрироваться.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
