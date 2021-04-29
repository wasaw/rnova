//
//  SpecialtyCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 4/16/21.
//

import UIKit

class SpecialtyCollectionViewCell: UICollectionViewCell {
    static let identifier = "SpecialtyCollectionViewCell"
    
    let labelDoctorName = UILabel()
    let labelProfession = UILabel()
    let doctorImageView = UIImageView()
    let doctorImage = UIImage(systemName: "person")
    let lineView = UIView()
    let labelNoTime = UILabel()
    var timeButtons: [UIButton] = []
//    var timeButton = UIButton()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 1.0
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
        
        labelDoctorName.textColor = .black
        labelDoctorName.font = UIFont.boldSystemFont(ofSize: 19)
        labelDoctorName.numberOfLines = 0
        self.addSubview(labelDoctorName)
        
        
        labelProfession.font = labelProfession.font.withSize(18)
        labelProfession.lineBreakMode = .byWordWrapping
        labelProfession.numberOfLines = 0
        labelProfession.textColor = .gray
        self.addSubview(labelProfession)
        
        doctorImageView.image = doctorImage
        self.addSubview(doctorImageView)
        
//        MARK: -line
        lineView.layer.borderWidth = 1
        lineView.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(lineView)
        
        labelNoTime.textColor = .black
        labelNoTime.text = "Нет свободного времени"
        labelNoTime.isHidden = true
        self.addSubview(labelNoTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        labelDoctorName.frame = CGRect(x: 100, y: 10, width: contentView.frame.width - 120, height: 60)
        labelProfession.frame = CGRect(x: 100, y: 60, width: contentView.bounds.width - 120, height: 100)
        lineView.frame = CGRect(x: 0, y: 160, width: contentView.frame.width, height: 1)
        doctorImageView.frame = CGRect(x: 20, y: 30, width: 60, height: 60)
        labelNoTime.frame = CGRect(x: 20, y: 180, width: 250, height: 20)
    }
    
    
    func createButton(for end: Int, arrTime: [String]) {
        var countX = 0
        var countY = 0
        var multiplier = 1
        var stop: Int
        if end == 0 {
            labelNoTime.isHidden = false
        }else {
            stop = end - 1
            for item in 0...stop {
                let button = UIButton(type: .system)
                button.setTitle(arrTime[item], for: .normal)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.systemOrange.cgColor
                button.backgroundColor = UIColor.white
                button.layer.cornerRadius = 15
                button.clipsToBounds = true
//                button.tag = arrTime[item]
                button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
                let startPudding = 20
                let padding = 80
                let y:CGFloat = 125
                let yPadding = 50
                let width: CGFloat = 70
                let height: CGFloat = 40
                let divisor = 3
                
                if countY ==  (divisor + 1) {
                    countY = 0
                    multiplier += 1
                }
                if countX == (divisor + 1) {
                    countX = 0
                }
                
                button.frame = CGRect(x: CGFloat(startPudding + padding * countX), y: (y + CGFloat(yPadding * multiplier)), width: width, height: height)
                countX += 1
                countY += 1
                self.addSubview(button)
            }
        }
        
        
        
    }
    
    @objc func buttonTap(sender: UIButton) {
//        let nav = UINavigationController()
//        nav.pushViewController(PersonalData(), animated: true)
//        print("press")
    }
    
   
//
//    func initButton(for item: Int) -> UIButton{
//        let button = UIButton(type: .system)
//        button.setTitle("Time", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.systemOrange.cgColor
//        button.backgroundColor = UIColor.white
//        button.layer.cornerRadius = 15
//        button.clipsToBounds = true
////        button.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
//        let startPudding = 20
//        let padding = 80
//        let y:CGFloat = 125
//        let yPadding = 50
//        let width: CGFloat = 70
//        let height: CGFloat = 40
//        let divisor = 3
//        var count = item
//        var multiplier = 1
//        while count > divisor {
//            count = count - divisor
//            multiplier += 1
//        }
//        if multiplier > 1 {
//            count = 0
//        }
//        print(count)
//        button.frame = CGRect(x: CGFloat(startPudding + padding * count), y: (y + CGFloat(yPadding * multiplier)), width: width, height: height)
//
//        return button
//    }

}

