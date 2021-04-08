//
//  ResultViewController.swift
//  rnova
//
//  Created by Александр Меренков on 1/22/21.
//

import UIKit

class VisitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let items = ["Будущие", "Прошедшие"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.backgroundColor = .orange
        customSC.frame = CGRect(x: 10, y: 110, width: view.frame.width - 20, height: 30)
        self.view.addSubview(customSC)
        
        let labelAnswer = UILabel(frame: CGRect(x: 10, y: 170, width: 170, height: 20))
        labelAnswer.text = "Нет результатов"
        labelAnswer.textColor = .black
        view.addSubview(labelAnswer)
        
    }
    

 

}
