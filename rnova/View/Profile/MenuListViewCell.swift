//
//  MenuListViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

private enum Constants {
    static let menuNameLabelPaddingLeft: CGFloat = 20
    static let menuNameLabelPaddingRight: CGFloat = 10
    static let menuNameLabelHeight: CGFloat = 30
    static let imageArrowMenuPaddings: CGFloat = 20
    static let imageArrowMenuHeight: CGFloat = 20
}

final class MenuListViewCell: UITableViewCell {
    static let identifire = "menuListCell"
    
//    MARK: - Properties
    
    private lazy var menuNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var imageMenu: UIImageView = {
        let image = UIImageView()
        image.tintColor = .gray
        return image
    }()
    
    private lazy var imageArrowMenu: UIImageView = {
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
        menuNameLabel.anchor(left: imageMenu.rightAnchor,
                             right: imageArrowMenu.leftAnchor,
                             paddingLeft: Constants.menuNameLabelPaddingLeft,
                             paddingRight: -Constants.menuNameLabelPaddingRight,
                             height: Constants.menuNameLabelHeight)
        imageArrowMenu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageArrowMenu.anchor(right: rightAnchor,
                              paddingRight: -Constants.imageArrowMenuPaddings,
                              height: Constants.imageArrowMenuHeight)
    }
    
    func setInformation(name: String, image: String) {
        menuNameLabel.text = name
        imageMenu.image = UIImage(systemName: image)
    }
    
}
