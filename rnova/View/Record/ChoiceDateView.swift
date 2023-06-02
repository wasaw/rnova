//
//  ChoiceDateView.swift
//  rnova
//
//  Created by Александр Меренков on 11/9/21.
//

import UIKit

private enum Constants {
    static let choiceDateLabelPaddingTop: CGFloat = 5
    static let buttonPaddingTop: CGFloat = 20
    static let buttonDimensions: CGFloat = 50
    static let dateDurationLabelPaddings: CGFloat = 20
    static let dateDurationLabelHeight: CGFloat = 50
}

protocol FlipCalendarDelegate: AnyObject {
    func flipCalendar(direction: FlipCalendar)
}

final class ChoiceDateView: UIView {
    
//    MARK: - Properties
    
    weak var delegate: FlipCalendarDelegate?

    private lazy var choiceDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбрать дату:"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var leftButton: UIButton = {
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
    
    private lazy var rightButton: UIButton = {
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
    
    private lazy var dateDurationLabel: UILabel = {
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
        
        choiceDateLabel.anchor(leading: leadingAnchor,
                               top: topAnchor,
                               trailing: trailingAnchor,
                               paddingTop: Constants.choiceDateLabelPaddingTop)
        leftButton.anchor(leading: leadingAnchor,
                          top: choiceDateLabel.bottomAnchor,
                          paddingTop: Constants.buttonPaddingTop,
                          width: Constants.buttonDimensions,
                          height: Constants.buttonDimensions)
        rightButton.anchor(top: choiceDateLabel.bottomAnchor,
                           trailing: trailingAnchor,
                           paddingTop: Constants.buttonPaddingTop,
                           width: Constants.buttonDimensions,
                           height: Constants.buttonDimensions)
        dateDurationLabel.anchor(leading: leftButton.trailingAnchor,
                                 top: choiceDateLabel.bottomAnchor,
                                 trailing: rightButton.leadingAnchor,
                                 paddingLeading: Constants.dateDurationLabelPaddings,
                                 paddingTop: Constants.dateDurationLabelPaddings,
                                 paddingTrailing: -Constants.dateDurationLabelPaddings,
                                 height: Constants.dateDurationLabelHeight)
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
