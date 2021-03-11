//
//  ClinicViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ClinicViewController: UIViewController {
    
    let firstView = UIView()
    let secondView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        buttonTopLeft.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
    
//    MARK: - firstView
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.layer.cornerRadius = 5
        
        firstView.layer.shadowOffset = CGSize(width: 0, height: 1)
        firstView.layer.shadowOpacity = 0.6
        firstView.layer.shadowRadius = 1.0
        firstView.clipsToBounds = false
        firstView.layer.masksToBounds = false
        firstView.backgroundColor = .white
        view.addSubview(firstView)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(firstView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(firstView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(firstView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220))
        constraints.append(firstView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        NSLayoutConstraint.activate(constraints)
        
        let firstTitleLabel = UILabel(frame: CGRect(x: 15, y: 15, width: 300, height: 20))
        firstTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        firstTitleLabel.textColor = .black
        firstTitleLabel.text = "ООО \"Клиника Преображенская\""
        firstView.addSubview(firstTitleLabel)
        
        let firstAdressLabel = UILabel(frame: CGRect(x: 15, y: 45, width: 350, height: 50))
        firstAdressLabel.textColor = .gray
        firstAdressLabel.font = UIFont.systemFont(ofSize: 14)
        firstAdressLabel.numberOfLines = 2
        firstAdressLabel.text = "350001, Краснодарский край, г. Краснодар, ул. Ставропольская, д. 210, к. Д, кв. 1"
        firstView.addSubview(firstAdressLabel)
        
        let firstEmailLabel = UILabel(frame: CGRect(x: 15, y: 95, width: 350, height: 20))
        firstEmailLabel.font = UIFont.systemFont(ofSize: 14)
        firstEmailLabel.textColor = .systemOrange
        firstEmailLabel.text = "klipre-rcp@mail.ru"
        let firstTap = UITapGestureRecognizer(target: self, action: #selector(firstSendEmail))
        firstEmailLabel.isUserInteractionEnabled = true
        firstEmailLabel.addGestureRecognizer(firstTap)
        firstView.addSubview(firstEmailLabel)
        
        let firstPhoneLabel = UILabel(frame: CGRect(x: 15, y: 115, width: 350, height: 20))
        firstPhoneLabel.font = UIFont.systemFont(ofSize: 14)
        firstPhoneLabel.textColor = .gray
        firstPhoneLabel.text = "+7(862)212-7-212"
        firstView.addSubview(firstPhoneLabel)
        
        let firstButton = UIButton(frame: CGRect(x: 15, y: 145, width: 140, height: 30))
        firstButton.setTitle("   Позвонить", for: .normal)
        firstButton.titleLabel?.font = UIFont(name: "System", size: 16)
        firstButton.setImage(UIImage(systemName: "phone"), for: .normal)
//        firstButton.contentHorizontalAlignment = .right
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.layer.cornerRadius = 5
        firstButton.backgroundColor = .systemYellow
        firstButton.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        firstView.addSubview(firstButton)
        
        
//  MARK: - secondView
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.layer.cornerRadius = 5
        
        secondView.layer.shadowOffset = CGSize(width: 0, height: 1)
        secondView.layer.shadowOpacity = 0.6
        secondView.layer.shadowRadius = 1.0
        secondView.clipsToBounds = false
        secondView.layer.masksToBounds = false
        secondView.backgroundColor = .white
        view.addSubview(secondView)
        
        var constraintsSecond = [NSLayoutConstraint]()
        constraintsSecond.append(secondView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240))
        constraintsSecond.append(secondView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraintsSecond.append(secondView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 440))
        constraintsSecond.append(secondView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        NSLayoutConstraint.activate(constraintsSecond)
        
        let secondTitleLabel = UILabel(frame: CGRect(x: 15, y: 15, width: 300, height: 20))
        secondTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondTitleLabel.textColor = .black
        secondTitleLabel.text = "ООО ЛДЦ \"Клиника Солнечная\""
        secondView.addSubview(secondTitleLabel)
        
        let secondAdressLabel = UILabel(frame: CGRect(x: 15, y: 45, width: 350, height: 50))
        secondAdressLabel.textColor = .gray
        secondAdressLabel.font = UIFont.systemFont(ofSize: 14)
        secondAdressLabel.numberOfLines = 2
        secondAdressLabel.text = "350049, Краснодарский край, г. Краснодар, ул. Красных Партизан, д. 128"
        secondView.addSubview(secondAdressLabel)
        
        let secondEmailLabel = UILabel(frame: CGRect(x: 15, y: 95, width: 350, height: 20))
        secondEmailLabel.font = UIFont.systemFont(ofSize: 14)
        secondEmailLabel.textColor = .systemOrange
        secondEmailLabel.text = "solnechnaya.klinika@mail.ru"
        let secondTap = UITapGestureRecognizer(target: self, action: #selector(secondSendEmail))
        secondEmailLabel.isUserInteractionEnabled = true
        secondEmailLabel.addGestureRecognizer(secondTap)
        secondView.addSubview(secondEmailLabel)
        
        let secondPhoneLabel = UILabel(frame: CGRect(x: 15, y: 115, width: 350, height: 20))
        secondPhoneLabel.font = UIFont.systemFont(ofSize: 14)
        secondPhoneLabel.textColor = .gray
        secondPhoneLabel.text = "+7(862)212-7-212"
        secondView.addSubview(secondPhoneLabel)
        
        let secondButton = UIButton(frame: CGRect(x: 15, y: 145, width: 140, height: 30))
        secondButton.setTitle("   Позвонить", for: .normal)
        secondButton.titleLabel?.font = UIFont(name: "System", size: 16)
        secondButton.setImage(UIImage(systemName: "phone"), for: .normal)
//        firstButton.contentHorizontalAlignment = .right
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.layer.cornerRadius = 5
        secondButton.backgroundColor = .systemYellow
        secondButton.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        secondView.addSubview(secondButton)
    
    }
    
//    MARK: - selectors
    
    @objc func firstSendEmail() {
        let email = "klipre-rcp@mail.ru"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func secondSendEmail() {
        let email = "solnechnaya.klinika@mail.ru"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func callButtonAction() {
        let phoneNumber = "+7(862)212-7-212"
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
    
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
          }
    }
    
}
