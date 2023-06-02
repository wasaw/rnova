//
//  MakeAppointmentController.swift
//  rnova
//
//  Created by Александр Меренков on 11/8/21.
//

import UIKit

private enum Constants {
    static let recordingViewHorizontalPaddings: CGFloat = 10
    static let recordingViewTopPadding: CGFloat = 20
    static let recordingViewHeight: CGFloat = 140
    static let contactViewHorizontalPaddings: CGFloat = 10
    static let contactViewPaddingTop: CGFloat = 30
    static let contactViewHeight: CGFloat = 320
    static let submitButtonHorizontalPaddings: CGFloat = 10
    static let submitButtonPaddingTop: CGFloat = 30
    static let submitButtonHeight: CGFloat = 60
}

protocol SendCommentProtocol {
    func gettingComment() -> String?
}

final class MakeAppointmentController: UIViewController {
    
//    MARK: - Properties
    
    private let doctor: Doctor
    private let selectedDate: Date
    private let selectedTime: String
    
    var delegateComment: SendCommentProtocol?
        
    private let databaseService = DatabaseService.shared
    
    private let datePicker = UIDatePicker()
    private let formatter = DateFormatter()
    
    private lazy var recordInformationView = RecordInformationView()
    private lazy var contactInformationView = ContactInformationView()
    
    private lazy var submitButton: UIButton = {
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
        recordInformationView.anchor(leading: view.leadingAnchor,
                                     top: view.safeAreaLayoutGuide.topAnchor,
                                     trailing: view.trailingAnchor,
                                     paddingLeading: Constants.recordingViewHorizontalPaddings,
                                     paddingTop: Constants.recordingViewTopPadding,
                                     paddingTrailing: -Constants.recordingViewHorizontalPaddings,
                                     height: Constants.recordingViewHeight)
        formatter.dateFormat = "dd.MM.yy"
        let date = selectedTime + " " + formatter.string(from: selectedDate)
        recordInformationView.setInformation(doctor, date: date)
    }
    
    private func configureContactInformationView() {
        view.addSubview(contactInformationView)
        delegateComment = contactInformationView
        contactInformationView.anchor(leading: view.leadingAnchor,
                                      top: recordInformationView.bottomAnchor,
                                      trailing: view.trailingAnchor,
                                      paddingLeading: Constants.contactViewHorizontalPaddings,
                                      paddingTop: Constants.contactViewPaddingTop,
                                      paddingTrailing: -Constants.contactViewHorizontalPaddings,
                                      height: Constants.contactViewHeight)
        
        databaseService.checkLogIn { result in
            switch result {
            case .success(let answer):
                if answer {
                    self.databaseService.getPersonInformation { result in
                        switch result {
                        case .success(let user):
                            self.contactInformationView.lastNameField.text = user.lastname
                            self.contactInformationView.firstNameField.text = user.firstname
                            self.contactInformationView.surnameField.text = user.surname
                            self.contactInformationView.dateField.text = String(user.date)
                            self.contactInformationView.phoneNumberField.text = user.phoneNumber
                        case .error(let error):
                            self.alert(with: "Ошибка", and: error.localizedDescription)
                        }
                    }
                } else {
                    self.alert(with: "Внимание", and: "Предварительно необходимо зарегистрироваться.")
                }
            case .error(let error):
                self.alert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
    private func configureSubmitButton() {
        view.addSubview(submitButton)
        submitButton.anchor(leading: view.leadingAnchor,
                            top: contactInformationView.bottomAnchor,
                            trailing: view.trailingAnchor,
                            paddingLeading: Constants.submitButtonHorizontalPaddings,
                            paddingTop: Constants.submitButtonPaddingTop,
                            paddingTrailing: -Constants.submitButtonHorizontalPaddings,
                            height: Constants.submitButtonHeight)
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
        databaseService.checkLogIn { result in
            switch result {
            case.success(let answer):
                if answer {
                    let clinic = "Моя клиника"
                    let comment = self.delegateComment?.gettingComment()
                    var fullComment: String
                    if comment == nil {
                        fullComment = ""
                    } else {
                        fullComment = comment!
                    }
                    let ticket = Appointment(doctor: self.doctor.name, profession: self.doctor.profession_titles, time: self.selectedTime, date: self.selectedDate, clinic: clinic, comment: fullComment)
                    self.databaseService.saveDoctorAppointment(ticket: ticket) { result in
                        switch result {
                        case .success(_):
                            self.alert(with: "Уведомление", and: "Поздравляем, вы успешно записались")
                            self.navigationController?.popToRootViewController(animated: true)
                        case .error(let error):
                            self.alert(with: "Ошибка", and: error.localizedDescription)
                        }
                    }
                } else {
                    self.alert(with: "Внимание", and: "Предварительно необходимо зарегистрироваться.")
                }
            case .error(let error):
                self.alert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
}
