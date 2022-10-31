//
//  MenuListViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

class MenuListViewCell: UITableViewCell {
    static let identifire = "menuListCell"
    
    let menuNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    let imageMenu: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        return image
    }()
    let imageArrowMenu: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(menuNameLabel)
        addSubview(imageMenu)
        addSubview(imageArrowMenu)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageMenu.frame = CGRect(x: 20, y: 10, width: 25, height: 25)
        
        menuNameLabel.translatesAutoresizingMaskIntoConstraints = false
        menuNameLabel.leftAnchor.constraint(equalTo: imageMenu.rightAnchor, constant: 20).isActive = true
        menuNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuNameLabel.rightAnchor.constraint(equalTo: imageArrowMenu.leftAnchor, constant: -10).isActive = true
        menuNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageArrowMenu.translatesAutoresizingMaskIntoConstraints = false
        imageArrowMenu.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        imageArrowMenu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageArrowMenu.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
