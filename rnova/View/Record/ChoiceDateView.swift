//
//  ChoiceDateView.swift
//  rnova
//
//  Created by Александр Меренков on 11/9/21.
//

import UIKit

protocol FlipCalendarDelegate: AnyObject {
    func flipCalendar(direction: FlipCalendar)
}

final class ChoiceDateView: UIView {
    
//    MARK: - Properties
    
    weak var delegate: FlipCalendarDelegate?

    private let choiceDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать дату:"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.systemOrange
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.systemOrange.cgColor
        let img = UIImage(systemName: "chevron.left")
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.systemOrange
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.systemOrange.cgColor
        let img = UIImage(systemName: "chevron.right")
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        return button
    }()
    
    private let dateDurationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
//    MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(choiceDateLabel)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(dateDurationLabel)
        
        choiceDateLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, paddingTop: 5)
        leftButton.anchor(left: leftAnchor, top: choiceDateLabel.bottomAnchor, paddingTop: 20, width: 50, height: 50)
        rightButton.anchor(top: choiceDateLabel.bottomAnchor, right: rightAnchor, paddingTop: 20, width: 50, height: 50)
        dateDurationLabel.anchor(left: leftButton.rightAnchor, top: choiceDateLabel.bottomAnchor, right: rightButton.leftAnchor, paddingLeft: 20, paddingTop: 20, paddingRight: -20, height: 50)
    }
    
    func setInformation(firstDay: String, lastDay: String) {
        dateDurationLabel.text = firstDay + " - " + lastDay
    }
    
//    MARK: - Selectors
    
    @objc private func handleLeftButton() {
        delegate?.flipCalendar(direction: .left)
    }
    
    @objc private func handleRightButton() {
        delegate?.flipCalendar(direction: .right)
    }
}
