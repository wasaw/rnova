//
//  MenuViewController.swift
//  rnova
//
//  Created by Александр Меренков on 2/2/21.
//

import UIKit

class MenuViewController: UIViewController {

   
    @IBOutlet weak var textOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .green
        title = "Выбор услуги"
        
        let label = UILabel(frame: view.bounds)
        view.addSubview(label)
        label.textAlignment = .center
        label.text = String(selectedId)
    }
    
    private let selectedId: Int
    
    init(selectedId: Int) {
        self.selectedId = selectedId 
        super.init(nibName: nil, bundle: nil )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
