//
//  ClinicViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/21/21.
//

import UIKit

class ClinicViewController: UIViewController {

    @IBOutlet weak var lableOutlet: UILabel!
    
    @IBOutlet weak var buttonOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOutlet.layer.cornerRadius = 0.5 * buttonOutlet.bounds.width
    }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        let phoneNumber = "+7(905)215-26-74"
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          } 
    }
    
}
