//
//  SpecialtyViewController.swift
//  rnova
//
//  Created by Александр Меренков on 3/4/21.
//

import UIKit

class SpecialtyChoiceViewController: UIViewController {

    private let id: Int
    
    var doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: "").doctorsData
    var professionsData = DataLoader(urlMethod: "&method=getProfessions", urlParameter: "").professionsData
    
    let textView = UITextView()
    let labelTitle = UILabel()
    let labelDoctorName = UILabel()
    let labelProfession = UILabel()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор времени"
        
        labelTitle.frame = CGRect(x: 20, y: 90, width: view.bounds.width - 40, height: 60)
        labelTitle.font = UIFont.boldSystemFont(ofSize: 22)
        for item in 0...professionsData.count - 1 {
            if professionsData[item].id == id {
                labelTitle.text = professionsData[item].name
                break
            }else {
                labelTitle.text = "Название специальности"
            }
        }
        view.addSubview(labelTitle)
        
        //MARK: - Add profession in description
        var textProfession = ""
        for item in 0...doctorsData.count - 1 {
            guard let str = doctorsData[item].profession else {
                continue
            }
            if str.count > 0 {
                for i in 0...str.count - 1 {
                    if Int(str[i]) == id {
                        labelDoctorName.text = doctorsData[item].name
                        for j in 0...professionsData.count - 1 {
                            for g in 0...str.count - 1 {
                                if professionsData[j].id == Int(str[g]) {
                                    textProfession = textProfession + professionsData[j].name + " "
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        
        textView.frame = CGRect(x: 20, y: 150, width: view.bounds.width - 40, height: 140)
        textView.layer.cornerRadius = 10
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 1)
        textView.layer.shadowOpacity = 1
        textView.layer.shadowRadius = 1.0
        textView.clipsToBounds = false
        textView.backgroundColor = .white
        view.addSubview(textView)
        
        let doctorImageView = UIImageView()
        let doctorImage = UIImage(systemName: "person")
        doctorImageView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        doctorImageView.image = doctorImage
        textView.addSubview(doctorImageView)

        labelDoctorName.frame = CGRect(x: 100, y: 20, width: textView.frame.width - 120, height: 30)
//        labelDoctorName.text = "Фамилия Имя Отчество"
        textView.addSubview(labelDoctorName)
        
        labelProfession.frame = CGRect(x: 100, y: 50, width: textView.bounds.width - 120, height: 90)
        labelProfession.font = labelProfession.font.withSize(18)
        labelProfession.lineBreakMode = .byWordWrapping
        labelProfession.numberOfLines = 4
        labelProfession.text = textProfession
        textView.addSubview(labelProfession)

        view.backgroundColor = .white
    }
    

    
}
