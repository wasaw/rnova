//
//  ProfileViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//
import SideMenu
import UIKit

class ProfileViewController: UIViewController, MenuControllerDelegate, UITextFieldDelegate {
    
//    private let selfDataController = ProfileViewController()
    private let visitController = VisitViewController()
    private let exitController = ExitViewController()
    
    private var sideMenu: SideMenuNavigationController?
    
    @IBOutlet weak var surnameOutlete: UITextField!
    @IBOutlet weak var nameOutlete: UITextField!
    @IBOutlet weak var midlenameOutlete: UITextField!
    @IBOutlet weak var dateOutlet: UITextField!
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let imageSelfData = UIImage(systemName: "person.fill")
        let menu = MenuController(with: ["Личные данные", "Визиты", "Выход"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.navigationBar.barTintColor = .systemOrange

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
                
        let bottomLineSurname = CALayer()
        bottomLineSurname.frame = CGRect(x: 0.0, y: surnameOutlete.frame.height - 5, width: surnameOutlete.frame.width, height: 1.0)
        bottomLineSurname.backgroundColor = UIColor.black.cgColor
        surnameOutlete.layer.addSublayer(bottomLineSurname)
        
        let bottomLineName = CALayer()
        bottomLineName.frame = CGRect(x: 0.0, y: nameOutlete.frame.height - 5, width: surnameOutlete.frame.width, height: 1.0)
        bottomLineName.backgroundColor = UIColor.black.cgColor
        nameOutlete.layer.addSublayer(bottomLineName)
        
        let bottomLineMidlename = CALayer()
        bottomLineMidlename.frame = CGRect(x: 0.0, y: midlenameOutlete.frame.height - 5, width: midlenameOutlete.frame.width, height: 1.0)
        bottomLineMidlename.backgroundColor = UIColor.black.cgColor
        midlenameOutlete.layer.addSublayer(bottomLineMidlename)
        
        let bottomLineDate = CALayer()
        bottomLineDate.frame = CGRect(x: 0.0, y: dateOutlet.frame.height - 5, width: dateOutlet.frame.width, height: 1.0)
        bottomLineDate.backgroundColor = UIColor.black.cgColor
        dateOutlet.layer.addSublayer(bottomLineDate)
        
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
    
 
//  MARK: - side menu
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
//        addChild(selfDataController)
        addChild(visitController)
        addChild(exitController)
        
//        view.addSubview(selfDataController.view)
        view.addSubview(visitController.view)
        view.addSubview(exitController.view)
        
//        selfDataController.view.frame = view.bounds
        visitController.view.frame = view.frame
        exitController.view.frame = view.frame
        
//        selfDataController.didMove(toParent: self)
        visitController.didMove(toParent: self)
        exitController.didMove(toParent: self)
        
//        selfDataController.view.isHidden = true
        visitController.view.isHidden = true
        exitController.view.isHidden = true
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            self?.title = named
            
            switch named {
            case  "Личные данные":
                self?.view.isHidden = false
//                self?.selfDataController.view.isHidden = false
                self?.visitController.view.isHidden = true
                self?.exitController.view.isHidden = true
            case "Визиты":
                self?.visitController.view.isHidden = false
                self?.view.isHidden = false
//                self?.selfDataController.view.isHidden = true
                self?.exitController.view.isHidden = true
            case "Выход":
                self?.exitController.view.isHidden = false
                self?.view.isHidden = false
//                self?.selfDataController.view.isHidden = true
                self?.visitController.view.isHidden = true
                
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
        cell.textLabel?.textColor = .black
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
