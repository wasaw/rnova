//
//  ChoiceDateView.swift
//  rnova
//
//  Created by Александр Меренков on 11/9/21.
//

import UIKit

class ChoiceDateView: UIView {

    let choiceDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать дату:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    let leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.systemOrange
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.systemOrange.cgColor
        let img = UIImage(systemName: "chevron.left")
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(DateRecordChoiceController.pressLeftButton), for: .touchUpInside)
        return button
    }()
    let rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.systemOrange
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.systemOrange.cgColor
        let img = UIImage(systemName: "chevron.right")
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(DateRecordChoiceController.pressRightButton), for: .touchUpInside)
        return button
    }()
    let dateDurationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(choiceDateLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(dateDurationLabel)
        
        backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        choiceDateLabel.translatesAutoresizingMaskIntoConstraints = false
        choiceDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        choiceDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        choiceDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftButton.topAnchor.constraint(equalTo: choiceDateLabel.bottomAnchor, constant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        rightButton.topAnchor.constraint(equalTo: choiceDateLabel.bottomAnchor, constant: 20).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        dateDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateDurationLabel.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 20).isActive = true
        dateDurationLabel.topAnchor.constraint(equalTo: choiceDateLabel.bottomAnchor, constant: 20).isActive = true
        dateDurationLabel.rightAnchor.constraint(equalTo: rightButton.leftAnchor, constant: -20).isActive = true
        dateDurationLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
