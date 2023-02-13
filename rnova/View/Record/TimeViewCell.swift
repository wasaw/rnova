//
//  TimeViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 11/5/21.
//

import UIKit

final class TimeViewCell: UICollectionViewCell {
    static let identifire = "TimeViewCell"
    
//    MARK: - Properties
    
    private let timeLabel: UILabel = {
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
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(timeLabel)
        timeLabel.anchor(left: leftAnchor, top: topAnchor, right: rightAnchor, bottom: bottomAnchor)
        layer.cornerRadius = 15
    }
    
    func setInformation(_ time: String) {
        timeLabel.text = time
    }
}
