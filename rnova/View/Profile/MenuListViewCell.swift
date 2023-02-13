//
//  MenuListViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

final class MenuListViewCell: UITableViewCell {
    static let identifire = "menuListCell"
    
//    MARK: - Properties
    
    private let menuNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private let imageMenu: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        return image
    }()
    
    private let imageArrowMenu: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        return image
    }()
    
//    MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        addSubview(menuNameLabel)
        addSubview(imageMenu)
        addSubview(imageArrowMenu)
        imageMenu.frame = CGRect(x: 20, y: 10, width: 25, height: 25)
        menuNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuNameLabel.anchor(left: imageMenu.rightAnchor, right: imageArrowMenu.leftAnchor, paddingLeft: 20, paddingRight: -10, height: 30)
        imageArrowMenu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageArrowMenu.anchor(right: rightAnchor, paddingRight: -20, height: 20)
    }
    
    func setInformation(name: String, image: String) {
        menuNameLabel.text = name
        imageMenu.image = UIImage(systemName: image)
    }
    
}
