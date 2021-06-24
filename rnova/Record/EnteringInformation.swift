//
//  EnteringInformation.swift
//  rnova
//
//  Created by Александр Меренков on 6/18/21.
//

import UIKit
import CoreData

class EnteringInformation: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    private var collectionView: UICollectionView?
    private let insents = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let lastNameField = UITextField()
    private let firstNameField = UITextField()
    private let surnameField = UITextField()
    private let commentField = UITextField()
    private let dateField = UITextField()
    private let phoneNumberField = UITextField()
    
    private let datePicker = UIDatePicker()
        
    private let recordButton = UIButton()
    private let registrationButton = UIButton()
//    private let enterButton = UIButton()
    
    private let doctorId: Int
    private let doctorName: String
    private let recordTime: String
    
//    private let professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
    
    private let doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(id: Int, name: String, time: String) {
        self.doctorId = id
        self.doctorName = name
        self.recordTime = time
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Личные данные"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(EnteringInformationViewCell.self, forCellWithReuseIdentifier: EnteringInformationViewCell.identifire)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        lastNameField.frame = CGRect(x: 20, y: 320, width: view.bounds.width - 40, height: 40)
        lastNameField.placeholder = "Фамилия"
        lastNameField.clearButtonMode = .always
        lastNameField.clearsOnBeginEditing = true
        line(y: 360)
        view.addSubview(lastNameField)
        
        firstNameField.frame = CGRect(x: 20, y: 390, width: view.bounds.width - 40, height: 40)
        firstNameField.placeholder = "Имя"
        firstNameField.clearButtonMode = .always
        firstNameField.clearsOnBeginEditing = true
        line(y: 430)
        view.addSubview(firstNameField)
        
        surnameField.frame = CGRect(x: 20, y: 460, width: view.bounds.width - 40, height: 40)
        surnameField.placeholder = "Отчество"
        surnameField.clearButtonMode = .always
        surnameField.clearsOnBeginEditing = true
        line(y: 500)
        view.addSubview(surnameField)
        
        commentField.frame = CGRect(x: 20, y: 530, width: view.bounds.width - 40, height: 40)
        commentField.placeholder = "Комментарий"
        commentField.clearButtonMode = .always
        commentField.clearsOnBeginEditing = true
        line(y: 570)
        view.addSubview(commentField)
        
        if checkLogIn() {
            
            let frame = CGRect(x: 20, y: 620, width: view.bounds.width - 40, height: 60)
            recordButton.createButton(frame: frame, color: UIColor.systemGreen, title: "Записаться")
            recordButton.addTarget(self, action: #selector(recordAppointment), for: .touchUpInside)
            view.addSubview(recordButton)
            
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            
            do {
                let result = try context.fetch(fetchRequest)
                for data in result {
                    if let data = data as? NSManagedObject {
                        lastNameField.text = data.value(forKey: "lastname") as? String ?? ""
                        firstNameField.text = data.value(forKey: "firstname") as? String ?? ""
                        surnameField.text = data.value(forKey: "surname") as? String ?? ""
                    }
                }
            } catch {
                print(error)
            }
        } else {
            dateField.frame = CGRect(x: 20, y: 600, width: view.bounds.width - 40, height: 40)
            dateField.placeholder = "Дата рождения"
            dateField.inputView = datePicker
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.datePickerMode = .date
            line(y: 640)
            view.addSubview(dateField)
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            dateField.inputAccessoryView = toolBar
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
            toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
            
            phoneNumberField.frame = CGRect(x: 20, y: 670, width: view.bounds.width - 40, height: 40)
            phoneNumberField.placeholder = "Телефонный номер"
            phoneNumberField.clearButtonMode = .always
            phoneNumberField.clearsOnBeginEditing = true
            line(y: 710)
            view.addSubview(phoneNumberField)
            
            let registrationFrame = CGRect(x: 20, y: 740, width: view.bounds.width - 40, height: 60)
            registrationButton.createButton(frame: registrationFrame, color: UIColor.systemGreen, title: "Зарегистрироваться")
            registrationButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
            view.addSubview(registrationButton)
        }
        
        view.backgroundColor = .white
    }
    
    //MARK: -collectionView parameters
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnteringInformationViewCell.identifire, for: indexPath) as? EnteringInformationViewCell else { return UICollectionViewCell() }
        
//        let doctorTitle = "Врач: "
//        let doctorText = "Баков Андрей Евгеньевич"
//        let attributedString = NSMutableAttributedString(string: doctorTitle)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.boldSystemFont(ofSize: 16)
//        ]
//        let doctorBold = NSMutableAttributedString(string: doctorText, attributes: attributes)
//        attributedString.append(doctorBold)
        let doctorAttributedString = boldFont(title: "Врач: ", text: doctorName)
        cell.doctorLabel.attributedText = doctorAttributedString
        
        var specialtyText = "Название специальности"
        for item in 0...doctorsData.count - 1 {
            if doctorsData[item].id == doctorId {
                if let specialty = doctorsData[item].profession_titles {
                    specialtyText = specialty
                    break
                }
            }
        }
        
        let specialtyAttributedString = boldFont(title: "Специальность: ", text: specialtyText)
        cell.specialtyLabel.attributedText = specialtyAttributedString
        
        let dateAttributedString = boldFont(title: "Дата: ", text: recordTime)
        cell.dateLabel.attributedText = dateAttributedString
        
        let clinicAttributedString = boldFont(title: "Клиника: ", text: "Семейная клиника")
        cell.clinicLabel.attributedText = clinicAttributedString
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
    
    func boldFont(title: String, text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let boldText = NSMutableAttributedString(string: text, attributes: attributes)
        attributedString.append(boldText)
        return attributedString
    }
    
    func line(y: CGFloat) {
        let line = UIView()
        line.frame = CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 1)
        line.backgroundColor = UIColor.lightGray
        view.addSubview(line)
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    @objc func cancelAction() {
        view.endEditing(true)
    }
    
    @objc func recordAppointment() {
        let context = appDelegate.persistentContainer.viewContext
        
        if checkLogIn() {
            guard let entity = NSEntityDescription.entity(forEntityName: "Record", in: context) else { return }

            let newRecord = NSManagedObject(entity: entity, insertInto: context)

            newRecord.setValue(doctorId, forKey: "doctor")
            newRecord.setValue(recordTime, forKey: "date")
            newRecord.setValue("Семейная клиника", forKey: "clinic")
            newRecord.setValue(commentField.text, forKey: "comment")
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//            fetchRequest.predicate =

            do {
                let result = try context.fetch(fetchRequest)
                guard let user = result.first as? NSManagedObject else { return }
                newRecord.setValue(user, forKey: "owner")
                let vc = VisitViewController()
                navigationController?.pushViewController(vc, animated: true)
            } catch {
                print(error)
            }
            
//            let recordFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
//            do {
//                let result = try context.fetch(recordFetchRequest)
//                guard let record = result.last as? NSManagedObject else { return }
//                guard let person = record.value(forKey: "owner") as? NSManagedObject else { return }
//                print(person.value(forKey: "lastname"))
//            } catch {
//
//            }
        } else {
            print("false")
        }
    }
    
    @objc func registration() {
        
        if firstNameField.text == "" && surnameField.text == "" && lastNameField.text == "" {
            let alert = UIAlertController(title: "Внимание", message: "Все поля обязательны для заполнения", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            
            do {
                let result = try context.fetch(fetchRequest)
                if (result.first as? NSManagedObject) != nil {
                    print("We have a person")
                } else {
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
                        let vc = VisitViewController()
                        navigationController?.pushViewController(vc, animated: true)
                    } catch {
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func checkLogIn() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        
        do {
            let result = try context.fetch(fetchRequest)
            if let user = result.first as? NSManagedObject {
                let checkLogIn = user.value(forKey: "login") as? Bool ?? false
                if checkLogIn {
                    return true
                }
            }
        } catch {
            print(error)
        }
        return false
    }
}
