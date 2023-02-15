//
//  LoginController.swift
//  rnova
//
//  Created by Александр Меренков on 11/25/21.
//

import UIKit

final class LoginController: UIViewController {
    
//    MARK: - Properties
    
    private let loginView = LoginView()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Вход"
        navigationController?.navigationBar.backgroundColor = .systemOrange
        
        configuretionView()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func configuretionView() {
        view.addSubview(loginView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(handleBackButton))
        navigationController?.navigationBar.tintColor = .white
        loginView.delegate = self
        loginView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
    }
    
    private func alert(fields: String) {
        let message = "Не заполнены следующие поля: " + fields
        let alert = UIAlertController(title: "Внимание!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func isValidPhoneNumber(number: String?) -> Bool {
        guard let number = number else { return false }
        let regEx = "^\\+7\\d{3}-\\d{3}-\\d{4}$"
        let phoneCheck = NSPredicate(format: "SELF MATCHES %@", regEx)
        return phoneCheck.evaluate(with: number)
    }
    
//  MARK: - Selectors
    
    @objc private func handleBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}

//  MARK: - Extensions

extension LoginController: SendLoginInformationProtocol {
    func sendLoginInformation(phoneNumber: String, password: String) {
        if isValidPhoneNumber(number: phoneNumber) {
            let databaseService = DatabaseService.shared
            DispatchQueue.main.async {
                databaseService.login(phoneNumber: phoneNumber, password: password) { result in
                    switch result {
                    case .success(_):
                        self.navigationController?.popToRootViewController(animated: true)
                    case .error(_):
                        self.alert(with: "Ошибка", and: "Неправильно введено поле логин или пароль")
                    }
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
