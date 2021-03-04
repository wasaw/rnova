//
//  SubViewController.swift
//  rnova
//
//  Created by Александр Меренков on 2/26/21.
//

import UIKit

class SubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var clinicsData = DataLoader(urlMethod: "&method=getClinics", urlParameter: "").clinicsData
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubView", for: indexPath)
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = clinicsData[indexPath.section].title
        }else {
            if let address = clinicsData[indexPath.section].address,
               let email = clinicsData[indexPath.section].email,
               let mobile = clinicsData[indexPath.section].mobile {
                cell.accessoryType = .none
                
                let labelAdress = UILabel(frame: CGRect(x: 20, y: 10, width: 400, height: 60))
                labelAdress.lineBreakMode = .byWordWrapping
                labelAdress.numberOfLines = 2
                labelAdress.text = address
                cell.addSubview(labelAdress)
                
                let labelEmail = UILabel(frame: CGRect(x: 20, y: 70, width: 200, height: 20))
                labelEmail.text = email
                cell.addSubview(labelEmail)
               
                let labelPhone = UILabel(frame: CGRect(x: 20, y: 100, width: 200, height: 20))
                labelPhone.text = mobile
                cell.addSubview(labelPhone)
            }else {
                cell.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if checkTapSegment {
            let vc = DoctorChoiceViewController(id: doctor_id, clinicId: clinicsData[indexPath.row].id)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = SpecialtyChoiceViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 44
        }
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return clinicsData.count
    }
    
    private let tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellSubView")
        return table
    }()

    
    
    
    let doctor_id: Int
    let checkTapSegment: Bool
//    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        label.frame = CGRect(x: 40, y: 40, width: 200, height: 200)
//        label.text = String(doctor_id)
//        view.addSubview(label)
        navigationItem.title = "Выбор клиники"
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    init(id: Int, checkTapSegment: Bool) {
        self.doctor_id = id
        self.checkTapSegment = checkTapSegment
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    
}



//extension SubViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubView", for: indexPath)
//        cell.textLabel?.text = "lolol"
//        return cell
//    }
//
//
//}
