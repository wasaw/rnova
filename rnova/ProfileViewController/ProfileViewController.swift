//
//  ProfileViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//
import SideMenu
import UIKit

class ProfileViewController: UIViewController {

    private let firstNameField = UITextField()
    private let secondNameField = UITextField()
    private let surnameField = UITextField()
    private let dateField = UITextField()
    
    private let datePicker = UIDatePicker()
    
    private let saveButton = UIButton()
    
    private var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageBar = UIImage(systemName: "line.horizontal.3")
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageBar, style: .plain, target: self, action: #selector(sideMenu))
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.navigationBar.backgroundColor = .systemOrange
        //        menu?.navigationController?.navigationBar.backgroundColor = .systemOrange
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        firstNameField.frame = CGRect(x: 20, y: 130, width: view.bounds.width - 40, height: 40)
        firstNameField.text = "Фамилия"
        firstNameField.clearButtonMode = .always
        line(y: 170)
        view.addSubview(firstNameField)
        
        secondNameField.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 40)
        secondNameField.text = "Имя"
        secondNameField.clearButtonMode = .always
        line(y: 240)
        view.addSubview(secondNameField)
        
        surnameField.frame = CGRect(x: 20, y: 270, width: view.bounds.width - 40, height: 40)
        surnameField.text = "Отчество"
        surnameField.clearButtonMode = .always
        line(y: 310)
        view.addSubview(surnameField)
        
        dateField.frame = CGRect(x: 20, y: 340, width: view.bounds.width - 40, height: 40)
        dateField.text = "Дата рождения"
        dateField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        line(y: 380)
        view.addSubview(dateField)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        dateField.inputAccessoryView = toolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        toolBar.setItems([cancelButton, flexSpace, doneButton], animated: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        view.addGestureRecognizer(tapGesture)
        
        saveButton.frame = CGRect(x: 20, y: 410, width: view.bounds.width - 40, height: 60)
        saveButton.layer.cornerRadius = 10
        saveButton.layer.shadowColor = UIColor.black.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        saveButton.layer.shadowOpacity = 0.3
        saveButton.layer.shadowRadius = 4
        saveButton.layer.masksToBounds = false
        saveButton.clipsToBounds = false
        saveButton.backgroundColor = .systemOrange
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        view.addSubview(saveButton)
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
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yy"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func sideMenu() {
        guard let menu = menu else { return }
        present(menu, animated: true)
    }
}

class MenuListController: UITableViewController {
    let items = ["Личные данные", "Визиты", "Выход"]
    let vc = [VisitViewController(), SelfDataViewController(), ExitViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .systemOrange
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc[indexPath.row], animated: true)
    }
}

