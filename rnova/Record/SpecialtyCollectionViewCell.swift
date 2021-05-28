//
//  SpecialtyCollectionViewCell.swift
//  rnova
//
//  Created by Александр Меренков on 4/16/21.
//

import UIKit

class SpecialtyCollectionViewCell: UICollectionViewCell {
    static let identifier = "SpecialtyCollectionViewCell"
    
    private let doctorImageView = UIImageView()
    private let doctorImage = UIImage(systemName: "person")
    private let labelNoTime = UILabel()
    private var timeButtons: [UIButton] = []
    let labelDoctorName = UILabel()
    let labelProfession = UILabel()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
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
        
        labelNoTime.textColor = .black
        labelNoTime.text = "Нет свободного времени"
        labelNoTime.isHidden = true
        self.addSubview(labelNoTime)
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelDoctorName.frame = CGRect(x: 100, y: 10, width: contentView.frame.width - 120, height: 60)
        labelProfession.frame = CGRect(x: 100, y: 60, width: contentView.bounds.width - 120, height: 100)
        doctorImageView.frame = CGRect(x: 20, y: 30, width: 60, height: 60)
        labelNoTime.frame = CGRect(x: 20, y: 180, width: 250, height: 20)

        line(y: 160)
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
    
}

