//
//  ProfileController.swift
//  rnova
//
//  Created by Александр Меренков on 11/23/21.
//

import UIKit
import SideMenu

class ProfileController: UIViewController {

    private let registrationView = RegistrationView()
    private let profileView = ProfileView()
    private let databaseService = DatabaseService()
    private var user: User?
    
    private var sideMenu: SideMenuNavigationController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if databaseService.checkLogIn() {
            DispatchQueue.main.async {
                self.user = self.databaseService.getPersonInformation()
                self.fillProfileView()
            }
            configureProfileView()
        } else {
            configureRegistrationView()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.backgroundColor = .systemOrange
                
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
    
    func configureProfileView() {
        view.addSubview(profileView)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        configureSideMenu()
    }
    
    func configureSideMenu() {
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(presentingSideMenu))
        
        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
        sideMenu?.leftSide = true
        sideMenu?.navigationBar.backgroundColor = .systemOrange
    }
    
    func fillProfileView() {
        guard let user = user else { return }
        profileView.lastnameUserLabel.text = user.lastname
        profileView.firstnameUserLabel.text = user.firstname
        profileView.surnameUserLabel.text = user.surname
        profileView.dateUserLabel.text = user.date
        profileView.phoneLabel.text = "  " + user.phoneNumber
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
    
    @objc func presentingSideMenu() {
        guard let sideMenu = sideMenu else { return }
        present(sideMenu, animated: true)
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
            fields = fields + "Номер телефона "
        }
        if user.password == "" {
            fields = fields + "Пароль"
        }
        if !fields.isEmpty {
            alert(fields: fields)
        }
        
        if isValidPhoneNumber(number: user.phoneNumber) {
            databaseService.registration(user: user)
            viewWillAppear(true)
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
