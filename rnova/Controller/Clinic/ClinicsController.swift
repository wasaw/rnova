//
//  ClinicsController.swift
//  rnova
//
//  Created by Александр Меренков on 10/21/21.
//

import UIKit
import MessageUI

final class ClinicsController: UIViewController {
    
//    MARK: - Properties
    
    private var collectionView: UICollectionView?
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    
    private var clinicsData = [Clinic]()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .systemOrange
        navigationItem.title = "Выбор клиники"
        loadInformation()
        configureCollectionView()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func loadInformation() {
        DispatchQueue.main.async {
            NetworkService.shared.request(method: .clinics) { (result: RequestStatus<[Clinic]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    self.clinicsData = answer
                    self.collectionView?.reloadData()
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }
            self.collectionView?.reloadData()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        collectionView.register(ClinicViewCell.self, forCellWithReuseIdentifier: ClinicViewCell.identifire)
        view.addSubview(collectionView)
        collectionView.anchor(left: view.leftAnchor, top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor)
        collectionView.backgroundColor = .white
    }
}

//  MARK: - Extensions

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
            cell.emailDelegate = self
            cell.phoneDelegate = self
            cell.setInformation(clinicsData[indexPath.row])
        }
        return cell
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

extension ClinicsController: SendMailDelegate {
    func sendEmail() {
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

extension ClinicsController: CallPhoneDelegate {
    func callPhone(_ phone: String) {
        let phoneNumber = phone.filter({!$0.isWhitespace})
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
