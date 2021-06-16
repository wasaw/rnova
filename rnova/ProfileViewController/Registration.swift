//
//  Registration.swift
//  rnova
//
//  Created by Александр Меренков on 6/10/21.
//

import UIKit
import CoreData

class Registration: UIViewController {
    
    private let lastNameField = UITextField()
    private let firstNameField = UITextField()
    private let surnameField = UITextField()
    private let dateField = UITextField()
    private let phoneNumberField = UITextField()
    
    private let datePicker = UIDatePicker()
    
    private let registrationButton = UIButton()
    private let enterButton = UIButton()
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = "Регистрация"
        
        lastNameField.frame = CGRect(x: 20, y: 130, width: view.bounds.width - 40, height: 40)
//        lastNameField.text = "Фамилия"
        lastNameField.placeholder = "Фамилия"
        lastNameField.clearButtonMode = .always
        lastNameField.clearsOnBeginEditing = true
        line(y: 170)
        view.addSubview(lastNameField)
        
        firstNameField.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 40)
//        firstNameField.text = "Имя"
        firstNameField.placeholder = "Имя"
        firstNameField.clearButtonMode = .always
        firstNameField.clearsOnBeginEditing = true
        line(y: 240)
        view.addSubview(firstNameField)
        
        surnameField.frame = CGRect(x: 20, y: 270, width: view.bounds.width - 40, height: 40)
//        surnameField.text = "Отчество"
        surnameField.placeholder = "Отчество"
        surnameField.clearButtonMode = .always
        surnameField.clearsOnBeginEditing = true
        line(y: 310)
        view.addSubview(surnameField)
        
        dateField.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 40)
//        dateField.text = "Дата рождения"
        dateField.placeholder = "Дата рождения"
        dateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        line(y: 380)
        view.addSubview(dateField)
        
        phoneNumberField.frame = CGRect(x: 20, y: 410, width: view.bounds.width - 40, height: 40)
        phoneNumberField.placeholder = "Телефонный номер"
        phoneNumberField.clearButtonMode = .always
        phoneNumberField.clearsOnBeginEditing = true
        line(y: 450)
        view.addSubview(phoneNumberField)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        dateField.inputAccessoryView = toolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
        
        registrationButton.frame = CGRect(x: 20, y: 480, width: view.bounds.width - 40, height: 60)
        registrationButton.layer.cornerRadius = 10
        registrationButton.layer.shadowColor = UIColor.black.cgColor
        registrationButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        registrationButton.layer.shadowOpacity = 0.3
        registrationButton.layer.shadowRadius = 4
        registrationButton.layer.masksToBounds = false
        registrationButton.clipsToBounds = false
        registrationButton.backgroundColor = .systemGreen
        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.setTitleColor(.white, for: .normal)
        registrationButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
        view.addSubview(registrationButton)
        
        enterButton.frame = CGRect(x: 20, y: 560, width: view.bounds.width - 40, height: 60)
        enterButton.layer.cornerRadius = 10
        enterButton.layer.shadowColor = UIColor.black.cgColor
        enterButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        enterButton.layer.shadowOpacity = 0.3
        enterButton.layer.shadowRadius = 4
        enterButton.layer.masksToBounds = false
        enterButton.clipsToBounds = false
        enterButton.backgroundColor = .systemOrange
        enterButton.setTitle("Войти", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.addTarget(self, action: #selector(enter), for: .touchUpInside)
        view.addSubview(enterButton)
        
        view.backgroundColor = .white
    }
    
    func line(y: CGFloat) {
        let line = UIView()
        line.frame = CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 1)
        line.backgroundColor = UIColor.lightGray
        view.addSubview(line)
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    @objc func cancelAction() {
        dateField.text = "Дата рождения"
        view.endEditing(true)
    }
    
    @objc func registration() {
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
        
        let newPerson = NSManagedObject(entity: entity, insertInto: context)
        
        newPerson.setValue(firstNameField.text, forKey: "firstname")
        newPerson.setValue(surnameField.text, forKey: "surname")
        newPerson.setValue(lastNameField.text, forKey: "lastname")
        newPerson.setValue(dateField.text, forKey: "date")
        newPerson.setValue(phoneNumberField.text, forKey: "phone")
        newPerson.setValue(true, forKey: "login")

        
        do {
            try context.save()
//            navigationController?.popViewController(animated: true)
            let vc = ProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    @objc func enter() {
//        let storyboard = UIStoryboard(name: "Enter", bundle: nil)
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func checkRegistration() -> Bool {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.isEmpty {
//                return true
//            }
//        } catch {
//            print(error)
//        }
//        return false
//    }
//
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        dateField.text = formatter.string(from: datePicker.date)
    }
}

