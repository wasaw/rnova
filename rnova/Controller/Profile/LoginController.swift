//
//  LoginController.swift
//  rnova
//
//  Created by Александр Меренков on 11/25/21.
//

import UIKit

class LoginController: UIViewController {
    
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Вход"
        navigationController?.navigationBar.backgroundColor = .systemOrange
        
        configuretionView()
        
        view.backgroundColor = .white
    }
    
    func configuretionView() {
        view.addSubview(loginView)
        
        loginView.delegate = self
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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

//MARK: - extension
extension LoginController: SendLoginInformationProtocol {
    func sendLoginInformation(phoneNumber: String, password: String) {
        if isValidPhoneNumber(number: phoneNumber) {
            let databaseService = DatabaseService()
            DispatchQueue.main.async {
                if databaseService.login(phoneNumber: phoneNumber, password: password) {
                    let vc = ProfileController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.alert(fields: "Неправильно введено поле логин или пароль")
                }
            }
            
        }else {
            alert(fields: """
                  Номер телефона.
                  Формат ввода номера
                  +7XXX-XXX-XXXX
                  """)
        }
    }
    
    
}
