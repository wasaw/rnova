//
//  ProfileController.swift
//  rnova
//
//  Created by Александр Меренков on 11/23/21.
//

import UIKit
import SideMenu

protocol ProfileControllerDelegate: AnyObject {
    func didTapMenuButton()
}

final class ProfileController: UIViewController {
    
//    MARK: - Properties
    
    weak var delegate: ProfileControllerDelegate?

    private let registrationView = RegistrationView()
    private let profileView = ProfileView()
    private let databaseService = DatabaseService()
    private var user: User?
    
    private var sideMenu: SideMenuNavigationController?
    
//  MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseService.checkLogIn { result in
            switch result {
            case .success(let answer):
                if answer {
                    DispatchQueue.main.async {
                        self.databaseService.getPersonInformation { result in
                            switch result {
                            case .success(let user):
                                self.user = user
                            case .error(let error):
                                self.alert(with: "Ошибка", and: error.localizedDescription)
                            }
                        }
                        self.fillProfileView()
                    }
                    self.configureProfileView()
                } else {
                    self.configureRegistrationView()
                }
            case .error(let error):
                self.alert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.backgroundColor = .systemOrange
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func configureRegistrationView() {
        view.addSubview(registrationView)
        
        registrationView.delegate = self
        registrationView.delegateShow = self
        registrationView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
    }
    
    private func configureProfileView() {
        view.addSubview(profileView)
        profileView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
        configureSideMenu()
    }
    
    private func configureSideMenu() {
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .done, target: self, action: #selector(presentingSideMenu))
        
//        let imageBar = UIImage(systemName: "line.horizontal.3")
//        navigationController?.navigationBar.tintColor = .white
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(presentingSideMenu))
//        
//        sideMenu = SideMenuNavigationController(rootViewController: MenuListController())
//        sideMenu?.leftSide = true
//        sideMenu?.navigationBar.backgroundColor = .systemOrange
    }
    
    private func fillProfileView() {
        guard let user = user else { return }
        profileView.setInformation(user)
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
    
//    MARK: - Selecters
    
    @objc private  func presentingSideMenu() {
//        guard let sideMenu = sideMenu else { return }
//        present(sideMenu, animated: true)
        delegate?.didTapMenuButton()
    }
}

//  MARK: - Extensions

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
            databaseService.registration(user: user) { result in
                switch result {
                case .success(let answer):
                    if answer {
                        self.viewWillAppear(true)
                    } else {
                        self.alert(with: "Внимание", and: "Вы уже зарегистрировались на этом устройстве")
                    }
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
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
