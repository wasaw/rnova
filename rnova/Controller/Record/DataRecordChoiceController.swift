//
//  DataRecordChoiceController.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

class DataRecordChoiceController: UIViewController {
    
    private let doctorId: Int
    
    init(id: Int) {
        self.doctorId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(doctorId)
        
        view.backgroundColor = .purple
    }
}
