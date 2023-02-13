//
//  ProfessionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 10/25/21.
//

import UIKit

final class ProfessionViewCell: UICollectionViewCell {
    static let identifire = "ProfessionViewCell"
    
//    MARK: - Properties
    
    private let specialtyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - Helpers
    
    private func configureUI() {
        self.addSubview(specialtyLabel)
        specialtyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        specialtyLabel.anchor(left: leftAnchor, paddingLeft: 20)
    }
    
    
    func setInformation(_ specialty: String) {
        specialtyLabel.text = specialty
    }
}
