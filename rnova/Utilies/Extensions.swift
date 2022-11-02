//
//  Extensions.swift
//  rnova
//
//  Created by Александр Меренков on 5/26/21.
//

import UIKit

//    MARK: - UIImageView

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//    MARK: - UICollectionViewCell

extension UICollectionViewCell {
    
    func shadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
        clipsToBounds = false
    }
}

//    MARK: - UIButton

extension UIButton {    
    func createButton(title: String) {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
        self.backgroundColor = .systemOrange
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
    }
}

// MARK: - UITextField

extension UITextField {
    func addLine() {
        let textFieldLine = CALayer()
        textFieldLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        textFieldLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(textFieldLine)
    }
}

//MARK: - UILabel

extension UILabel {
    func addLine() {
        let textFieldLine = CALayer()
        textFieldLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        textFieldLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(textFieldLine)
    }
    
    func recordLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.text = text
        return label
    }
    
    func recordOutputLabel(_ text: String = "") -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = text
        return label
    }
    
    func profileLabel(size: CGFloat = 19) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .black
        
        let labelLine = CALayer()
        labelLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        labelLine.backgroundColor = UIColor.lightGray.cgColor
        label.layer.addSublayer(labelLine)
        return label
    }
    
    func profileTitleLabel(_ text: String, size: CGFloat = 15) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .lightGray
        label.text = text
        return label
    }
}

//  MARK: - UIView

extension UIView {
    func anchor(left: NSLayoutXAxisAnchor? = nil, top: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, paddingLeft: CGFloat = 0, paddingTop: CGFloat = 0, paddingRight: CGFloat = 0, paddingBottom: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func getButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.3
        button.layer.masksToBounds = false
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    func fieldForForm(placeholder: String, isSecure: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        tf.textColor = .black
        tf.clearButtonMode = .always
        tf.clearsOnBeginEditing = true
        tf.isSecureTextEntry = isSecure
        
        let line = UIView()
        tf.addSubview(line)
        line.anchor(left: tf.leftAnchor, top: tf.bottomAnchor, right: tf.rightAnchor, height: 1)
        line.backgroundColor = .lightGray
        return tf
    }
}
