//
//  ProfileViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//
import SideMenu
import UIKit

class ProfileViewController: UIViewController, MenuControllerDelegate, UITextFieldDelegate {
    
    private let selfDataController = SelfDataViewController()
    private let resultController = ResultViewController()
    private let helpController = HelpViewController()
    private let exitController = ExitViewController()
    
    private var sideMenu: SideMenuNavigationController?
    
    @IBOutlet weak var surnameOutlete: UITextField!
    @IBOutlet weak var nameOutlete: UITextField!
    @IBOutlet weak var midlenameOutlete: UITextField!
    @IBOutlet weak var dateOutlet: UITextField!
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: ["Личные данные", "Результаты", "Помощь", "Выход"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)

        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
        
        surnameOutlete.delegate = self
        nameOutlete.delegate = self
        midlenameOutlete.delegate = self
        
        surnameOutlete.clearButtonMode = .always
        nameOutlete.clearButtonMode = .always
        midlenameOutlete.clearButtonMode = .always
        
        dateOutlet.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        dateOutlet.inputAccessoryView = toolBar
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        surnameOutlete.resignFirstResponder()
        nameOutlete.resignFirstResponder()
        midlenameOutlete.resignFirstResponder()
        return true
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd:MM:yy"
        dateOutlet.text = formatter.string(from: datePicker.date)
    }
    
    @objc func tapGestureDone() {
        view.endEditing(true)
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        present(sideMenu!, animated: true)
    }
    
    private func addChildControllers() {
        addChild(selfDataController)
        addChild(resultController)
        addChild(helpController)
        addChild(exitController)
        
        view.addSubview(selfDataController.view)
        view.addSubview(resultController.view)
        view.addSubview(helpController.view)
        view.addSubview(exitController.view)
        
        selfDataController.view.frame = view.bounds
        resultController.view.frame = view.frame
        helpController.view.frame = view.frame
        exitController.view.frame = view.frame
        
        selfDataController.didMove(toParent: self)
        resultController.didMove(toParent: self)
        helpController.didMove(toParent: self)
        exitController.didMove(toParent: self)
        
        selfDataController.view.isHidden = true
        resultController.view.isHidden = true
        helpController.view.isHidden = true
        exitController.view.isHidden = true
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            self?.title = named
            
            switch named {
            case  "Личные данные":
                self?.selfDataController.view.isHidden = false
                self?.resultController.view.isHidden = true
                self?.helpController.view.isHidden = true
                self?.exitController.view.isHidden = true
            case "Результаты":
                self?.selfDataController.view.isHidden = true
                self?.resultController.view.isHidden = false
                self?.helpController.view.isHidden = true
                self?.exitController.view.isHidden = true
            case "Помощь":
                self?.selfDataController.view.isHidden = true
                self?.resultController.view.isHidden = true
                self?.helpController.view.isHidden = false
                self?.exitController.view.isHidden = true
            case "Выход":
                self?.selfDataController.view.isHidden = true
                self?.resultController.view.isHidden = true
                self?.helpController.view.isHidden = true
                self?.exitController.view.isHidden = false
            default:
                return
            }
        })
    }
    
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}

class MenuController: UITableViewController {
    public var delegate: MenuControllerDelegate?
    
    private let menuItems: [String]
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.tintColor = .black
        cell.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectItem)
    }
}
