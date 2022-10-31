//
//  View.swift
//  rnova
//
//  Created by Александр Меренков on 10/12/21.
//

import UIKit

class View: UIView {
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = false
        button.setTitleColor(.white, for: .normal)
        return button
    }()
}
