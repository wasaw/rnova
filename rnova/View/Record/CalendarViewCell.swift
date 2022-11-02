//
//  CalendarViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/2/21.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
    static let identifire = "CalendarViewCell"
    
//    MARK: - Properties
    
    private let calendarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
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
        addSubview(calendarLabel)
        calendarLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, bottom: bottomAnchor)
    }
    
    func setInformation(_ date: String) {
        calendarLabel.text = date
    }
    
    func resetDate() {
        backgroundColor = .white
    }
    
    func selectDate() {
        backgroundColor = .orange
    }
}
