//
//  ClinicViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ClinicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
// MARK: - UILabelFirst
        let label = UIView(frame: CGRect(x: 10, y: 95, width: 390, height: 210))
//        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        label.layer.borderWidth = 3.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        label.layer.shadowOpacity = 0.7
        label.layer.shadowRadius = 4.0

        
        let labelClinicName = UILabel(frame: CGRect(x: 20, y: 110, width: 270, height: 20))
        labelClinicName.text = "Семейная клиника"
        labelClinicName.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(labelClinicName)
        
        let labelAdress = UILabel(frame: CGRect(x: 20, y: 140, width: 370, height: 50))
        labelAdress.text = "г. Санкт-Петербург, ул. Матроса Железняка, д. 57, к. А"
        labelAdress.numberOfLines = 2
//        labelAdress.layer.borderColor = .init(red: 0, green: 0, blue: 254, alpha: 1)
//        labelAdress.layer.borderWidth = 3
        view.addSubview(labelAdress)
        
        let labelEmail = UITextField(frame: CGRect(x: 20, y: 200, width: 370, height: 20))
        labelEmail.text = "family.clinic@rnova.org"
        view.addSubview(labelEmail)
        
        let labelLine = UITextField(frame: CGRect(x: 20, y: 230, width: 370, height: 10))
        labelLine.text = "------------------------------------------------"
        view.addSubview(labelLine)
        
        let buttonTopLeft = UIButton(frame: CGRect(x: 20, y: 250, width: 140, height: 30))
        buttonTopLeft.setTitle("Позвонить", for: .normal)
        buttonTopLeft.setTitleColor(.black, for: .normal)
        buttonTopLeft.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonTopLeft.backgroundColor = .yellow
        buttonTopLeft.setImage(UIImage(systemName: "teletype.answer"), for: .normal)
        buttonTopLeft.tintColor = .systemOrange
//        buttonTopLeft.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 10)
        buttonTopLeft.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        buttonTopLeft.layer.cornerRadius = 0.05 * buttonTopLeft.bounds.size.width
        buttonTopLeft.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
        view.addSubview(buttonTopLeft)
        
        let buttonTopRight = UIButton(frame: CGRect(x: 170, y: 250, width: 120, height: 30))
        buttonTopRight.setTitle("На карте", for: .normal)
        buttonTopRight.setTitleColor(.black, for: .normal)
        buttonTopRight.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonTopRight.backgroundColor = .yellow
        buttonTopRight.setImage(UIImage(systemName: "mappin"), for: .normal)
        buttonTopRight.tintColor = .systemOrange
//        buttonTopRight.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 10)
        buttonTopRight.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        buttonTopRight.layer.cornerRadius = 0.05 * buttonTopRight.bounds.size.width
//        buttonTopRight.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
        view.addSubview(buttonTopRight)
        
        
// MARK: - UILabelButtom
        let labelBottom = UILabel(frame: CGRect(x: 10, y: 320, width: 390, height: 210))
        view.addSubview(labelBottom)
        
        let labelBottomClinicName = UILabel(frame: CGRect(x: 20, y: 345, width: 270, height: 20))
        labelBottomClinicName.text = "Фиилиал стационара"
        labelBottomClinicName.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(labelBottomClinicName)
        
        let labelBottomLine = UITextField(frame: CGRect(x: 20, y: 395, width: 370, height: 10))
        labelBottomLine.text = "------------------------------------------------"
        view.addSubview(labelBottomLine)
        
        let buttonBottomTopLeft = UIButton(frame: CGRect(x: 20, y: 415, width: 140, height: 30))
        buttonBottomTopLeft.setTitle("Позвонить", for: .normal)
        buttonBottomTopLeft.setTitleColor(.black, for: .normal)
        buttonBottomTopLeft.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonBottomTopLeft.backgroundColor = .yellow
        buttonBottomTopLeft.setImage(UIImage(systemName: "teletype.answer"), for: .normal)
        buttonBottomTopLeft.tintColor = .systemOrange
//        buttonTopLeft.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 10)
        buttonBottomTopLeft.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        buttonBottomTopLeft.layer.cornerRadius = 0.05 * buttonBottomTopLeft.bounds.size.width
        buttonBottomTopLeft.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
        view.addSubview(buttonBottomTopLeft)
        
        let buttonBottomTopRight = UIButton(frame: CGRect(x: 170, y: 415, width: 120, height: 30))
        buttonBottomTopRight.setTitle("На карте", for: .normal)
        buttonBottomTopRight.setTitleColor(.black, for: .normal)
        buttonBottomTopRight.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonBottomTopRight.backgroundColor = .yellow
        buttonBottomTopRight.setImage(UIImage(systemName: "mappin"), for: .normal)
        buttonBottomTopRight.tintColor = .systemOrange
//        buttonTopRight.contentEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 10)
        buttonBottomTopRight.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        buttonBottomTopRight.layer.cornerRadius = 0.05 * buttonBottomTopRight.bounds.size.width
//        buttonTopRight.addTarget(self, action: #selector(callButtonAction(_:)), for: .touchUpInside)
        view.addSubview(buttonBottomTopRight)
        
        
//        buttonOutlet.layer.cornerRadius = 0.05 * buttonOutlet.bounds.size.width
//        buttonOutletLow.layer.cornerRadius = 0.05 * buttonOutletLow.bounds.size.width
////        buttonOutlet.clipsToBounds = true
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        let phoneNumber = "+7(862)212-7-212"
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          } 
    }
    
}
