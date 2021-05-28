//
//  ClinicViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ClinicViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    let clinicsData = DataLoader(urlMethod: "&method=getClinics", urlParameter: "").clinicsData
    let cellID = "ClinicCell"
    let insents = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    
    let firstView = UIView()
    let secondView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        
        view.backgroundColor = UIColor.white
    }
}

//MARK: -extension
extension ClinicViewController: UICollectionViewDelegate {
    
}

extension ClinicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clinicsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ClinicCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = clinicsData[indexPath.row].title
        let adress = clinicsData[indexPath.row].address ?? ""
        let email = clinicsData[indexPath.row].email ?? ""
        cell.emailLabel.text = email
        cell.emailLabel.tag = indexPath.row
        cell.addressLabel.text = adress
        let phone = clinicsData[indexPath.row].mobile ?? ""
        cell.phoneLabel.text = phone
        if cell.frame.height == 50 {
            cell.button.isHidden = true
        }
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        
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
    
}

extension ClinicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 40
        var height: CGFloat
        if indexPath.row == 0 {
            height = 200
        }else {
            height = 50
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insents
    }
}
