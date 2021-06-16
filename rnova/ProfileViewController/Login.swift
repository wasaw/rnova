//
//  Login.swift
//  rnova
//
//  Created by Александр Меренков on 6/13/21.
//

import UIKit
import CoreData

class Login: UIViewController {
    
    private let lastNameField = UITextField()
    private let phoneNumberField = UITextField()
    
    private let registrationButton = UIButton()
    private let enterButton = UIButton()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = "Вход"
        
        lastNameField.frame = CGRect(x: 20, y: 130, width: view.bounds.width - 40, height: 40)
//        lastNameField.text = "Фамилия"
        lastNameField.placeholder = "Фамилия"
        lastNameField.clearButtonMode = .always
        lastNameField.clearsOnBeginEditing = true
        line(y: 170)
        view.addSubview(lastNameField)
        
        phoneNumberField.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 40)
        phoneNumberField.placeholder = "Телефонный номер"
        phoneNumberField.clearButtonMode = .always
        phoneNumberField.clearsOnBeginEditing = true
        line(y: 240)
        view.addSubview(phoneNumberField)
        
        registrationButton.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 60)
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
        
        enterButton.frame = CGRect(x: 20, y: 270, width: view.bounds.width - 40, height: 60)
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
    
    @objc func registration() {
        
        print("DEBUG: registration")
        let vc = Registration()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func enter() {
        print("DEBUG: enter")
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequesst = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequesst)
            if let user = result.first as? NSManagedObject {
                let phoneNumber = user.value(forKey: "phone") as? String ?? ""
                let lastName = user.value(forKey: "lastname") as? String ?? ""
                if phoneNumberField.text == phoneNumber && lastNameField.text == lastName {
                    user.setValue(true, forKey: "login")
                }
            }
        } catch {
            print(error)
        }
            
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


//class Login: UIViewController {
//    private let phoneNumberField = UITextField()
//    private let lastNameField = UITextField()
//    private let newView = UIView()
//    private let enterButton = UIButton()
//    private let cancelButton = UIButton()
//    private let width:CGFloat = 350
//
//    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        view.addSubview(newView)
//
//        newView.translatesAutoresizingMaskIntoConstraints = false
//        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        newView.widthAnchor.constraint(equalToConstant: width).isActive = true
//        newView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        newView.layer.cornerRadius = 10
//
//        phoneNumberField.frame = CGRect(x: 10, y: 20, width: width - 20, height: 40)
//        phoneNumberField.placeholder = "Номер телефона"
//        phoneNumberField.clearButtonMode = .always
//        phoneNumberField.clearsOnBeginEditing = true
//        line(y: 60)
//        newView.addSubview(phoneNumberField)
//
//        lastNameField.frame = CGRect(x: 10, y: 80, width: width - 20, height: 40)
//        lastNameField.placeholder = "Фамилия"
//        lastNameField.clearButtonMode = .always
//        lastNameField.clearsOnBeginEditing = true
//        line(y: 120)
//        newView.addSubview(lastNameField)
//
//        cancelButton.frame = CGRect(x: 10, y: 140, width: (width - 25) / 2, height: 40)
//        cancelButton.setTitle("Отмена", for: .normal)
//        cancelButton.backgroundColor = .red
//        cancelButton.layer.cornerRadius = 10
//        cancelButton.layer.shadowColor = UIColor.black.cgColor
//        cancelButton.layer.shadowOffset = CGSize(width: 0, height: 1)
//        cancelButton.layer.shadowOpacity = 0.3
//        cancelButton.layer.shadowRadius = 4
//        cancelButton.layer.masksToBounds  = false
//        cancelButton.setTitleColor(.white, for: .normal)
//        cancelButton.addTarget(self, action: #selector(closing), for: .touchUpInside)
//        newView.addSubview(cancelButton)
//
//        enterButton.frame = CGRect(x: (width - 20) / 2 + 10, y: 140, width: (width - 25) / 2, height: 40)
//        enterButton.setTitle("Вход", for: .normal)
//        enterButton.backgroundColor = .systemOrange
//        enterButton.layer.cornerRadius = 10
//        enterButton.layer.shadowColor = UIColor.black.cgColor
//        enterButton.layer.shadowOffset = CGSize(width: 0, height: 1)
//        enterButton.layer.shadowOpacity = 0.3
//        enterButton.layer.shadowRadius = 4
//        enterButton.layer.masksToBounds  = false
//        enterButton.setTitleColor(.white, for: .normal)
//        enterButton.addTarget(self, action: #selector(entrance), for: .touchUpInside)
//        newView.addSubview(enterButton)
//
//        navigationItem.leftBarButtonItem = .none
//        newView.backgroundColor = .white
//        view.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)
//
//    }
//
//    func line(y: CGFloat) {
//        let line = UIView()
//        line.frame = CGRect(x: 10, y: Int(y), width: Int(width) - 20, height: 1)
//        line.backgroundColor = UIColor.lightGray
//        newView.addSubview(line)
//    }
//
//    @objc func entrance() {
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            guard let user = result.first as? NSManagedObject else { return }
//            let phoneNumber = user.value(forKey: "phone") as? String ?? ""
//            let lastName = user.value(forKey: "lastname") as? String ?? ""
//            if phoneNumberField.text == phoneNumber && lastNameField.text == lastName {
//
//                navigationController?.pushViewController(vc, animated: true)
//            }
//        } catch {
//            print(error)
//        }
//
////        dismiss(animated: true, completion: nil)
//    }
//
//    @objc func closing() {
//        dismiss(animated: true, completion: nil)
//    }
//}
