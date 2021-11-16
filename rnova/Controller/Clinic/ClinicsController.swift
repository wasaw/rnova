//
//  ClinicsController.swift
//  rnova
//
//  Created by Александр Меренков on 10/21/21.
//

import UIKit
import MessageUI
import Alamofire

class ClinicsController: UIViewController {
    private var collectionView: UICollectionView?
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    private var clinicsData = [Clinic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationItem.title = "Выбор клиники"
        
        DispatchQueue.main.async {
            self.clinicsData = DataLoader(urlMethod: "&method=getClinics", urlParameter: "").clinicsData
            self.collectionView?.reloadData()
        }
        
        configureCollectionView()
        
        view.backgroundColor = .white
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: ClinicViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: ClinicViewCell.identifire)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ClinicsController: UICollectionViewDelegate {
    
}

extension ClinicsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !clinicsData.isEmpty {
            return clinicsData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClinicViewCell.identifire, for: indexPath) as? ClinicViewCell else { return UICollectionViewCell() }
        if !clinicsData.isEmpty {
            cell.titleLabel.text = clinicsData[indexPath.row].title
            cell.addressLabel.text = clinicsData[indexPath.row].address
            let tap = UITapGestureRecognizer(target: self, action: #selector(sendMail))
            cell.emailLabel.text = clinicsData[indexPath.row].email
            cell.emailLabel.addGestureRecognizer(tap)
            cell.phoneLabel.text = clinicsData[indexPath.row].mobile
            cell.button.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        }
        return cell
    }
    
    @objc func callButtonAction(sender: UIButton) {
        guard let phone = clinicsData[sender.tag].mobile else {return}
        let phoneNumber = phone.filter({!$0.isWhitespace})
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func sendMail() {
        let email = "info@myclinic.ru"
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
                if let url = URL(string: "mailto:\(email)") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.openURL(url)
                    } else {
                        UIApplication.shared.open(url)
                    }
                }
            return
        } else {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            
            present(mail, animated: true)
        }
    }
}

extension ClinicsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height = 200.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
}

extension ClinicsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
