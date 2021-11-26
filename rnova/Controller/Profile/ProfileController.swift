//
//  ProfileController.swift
//  rnova
//
//  Created by Александр Меренков on 11/23/21.
//

import UIKit

class ProfileController: UIViewController {
    
    private let registrationView = RegistrationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.backgroundColor = .systemOrange
        
        configureRegistrationView()
        
        view.backgroundColor = .white
    }
    
    func configureRegistrationView() {
        view.addSubview(registrationView)
        
        registrationView.delegate = self
        registrationView.delegateShow = self
        
        registrationView.translatesAutoresizingMaskIntoConstraints = false
        registrationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        registrationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        registrationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func alert(fields: String) {
        let message = "Не заполнены следующие поля: " + fields
        let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidPhoneNumber(number: String?) -> Bool {
        guard let number = number else { return false }
        let regEx = "^\\+7\\d{3}-\\d{3}-\\d{4}$"
        let phoneCheck = NSPredicate(format: "SELF MATCHES %@", regEx)
        return phoneCheck.evaluate(with: number)
    }
}

//MARK: -extension
extension ProfileController: SendValueProtocol {
    func recordUser(user: User) {
        var fields = ""
        if user.lastname == "" {
            fields = "Фамилия "
        }
        if user.firstname == "" {
            fields = fields + "Имя "
        }
        if user.surname == "" {
            fields = fields + "Отчество "
        }
        if user.date == "" {
            fields = fields + "Дата "
        }
        if user.phoneNumber == "" {
            fields = fields + "Номер телефона"
        }
        if !fields.isEmpty {
            alert(fields: fields)
        }
        
        if isValidPhoneNumber(number: user.phoneNumber) {
            print("DEBUG: saving")
        } else {
            alert(fields: """
                  Номер телефона.
                  Формат ввода номера
                  +7XXX-XXX-XXXX
                  """)
        }
    }
}

extension ProfileController: PresentViewProtocol {
    func showNewView() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
