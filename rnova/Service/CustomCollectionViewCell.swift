//
//  CustomCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 3/30/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
   
    let label = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        label.font = label.font.withSize(20)
        label.textColor = .black
        contentView.addSubview(label)
        
        shadow()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 20, y: contentView.frame.size.height - 60, width: contentView.frame.size.width - 20, height: 30)
    }
}
