////
////  Login.swift
////  rnova
////
////  Created by Александр Меренков on 6/13/21.
////
//
//import UIKit
//import CoreData
//
//class Login: UIViewController {
//    
//    private let lastNameField = UITextField()
//    private let phoneNumberField = UITextField()
//    
//    private let registrationButton = View().button
//    private let enterButton = View().button
//    
//    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.setHidesBackButton(true, animated: false)
//        navigationItem.title = "Вход"
//        
//        lastNameField.frame = CGRect(x: 20, y: 130, width: view.bounds.width - 40, height: 40)
//        lastNameField.placeholder = "Фамилия"
//        lastNameField.clearButtonMode = .always
//        lastNameField.clearsOnBeginEditing = true
//        line(y: 170)
//        view.addSubview(lastNameField)
//        
//        phoneNumberField.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 40)
//        phoneNumberField.placeholder = "Телефонный номер"
//        phoneNumberField.clearButtonMode = .always
//        phoneNumberField.clearsOnBeginEditing = true
//        line(y: 240)
//        view.addSubview(phoneNumberField)
//        
////        let registrationFrame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 60)
//        registrationButton.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 60)
////        registrationButton.createButton(frame: registrationFrame, color: UIColor.systemGreen, title: "Зарегистрироваться")
//        registrationButton.backgroundColor = UIColor.systemGreen
//        registrationButton.setTitle("Зарегистрироваться", for: .normal)
//        registrationButton.addTarget(self, action: #selector(registration), for: .touchUpInside)
//        view.addSubview(registrationButton)
//        
////        let enterFrame = CGRect(x: 20, y: 270, width: view.bounds.width - 40, height: 60)
//        enterButton.frame = CGRect(x: 20, y: 270, width: view.bounds.width - 40, height: 60)
////        enterButton.createButton(frame: enterFrame, color: UIColor.systemOrange, title: "Войти")
//        enterButton.backgroundColor = UIColor.systemOrange
//        enterButton.setTitle("Войти", for: .normal)
//        enterButton.addTarget(self, action: #selector(enter), for: .touchUpInside)
//        view.addSubview(enterButton)
//        
//        view.backgroundColor = .white
//    }
//    
//    func line(y: CGFloat) {
//        let line = UIView()
//        line.frame = CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 1)
//        line.backgroundColor = UIColor.lightGray
//        view.addSubview(line)
//    }
//    
//    @objc func registration() {
//        let vc = Registration()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @objc func enter() {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequesst = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//        
//        do {
//            let result = try context.fetch(fetchRequesst)
//            if let user = result.first as? NSManagedObject {
//                let phoneNumber = user.value(forKey: "phone") as? String ?? ""
//                let lastName = user.value(forKey: "lastname") as? String ?? ""
//                if phoneNumberField.text == phoneNumber && lastNameField.text == lastName {
//                    user.setValue(true, forKey: "login")
//                }
//            }
//        } catch {
//            print(error)
//        }
//            
//        let vc = ProfileViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//}
