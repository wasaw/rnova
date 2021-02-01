//
//  ClinicViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ClinicViewController: UIViewController {

    @IBOutlet weak var lableOutlet: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var buttonOutletLow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 0.05 * buttonOutlet.bounds.size.width
        buttonOutletLow.layer.cornerRadius = 0.05 * buttonOutletLow.bounds.size.width
//        buttonOutlet.clipsToBounds = true
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
