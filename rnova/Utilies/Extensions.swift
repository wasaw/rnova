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
    func line(y: CGFloat) {
        let lineView = UIView()
        lineView.frame = CGRect(x: 0, y: y, width: bounds.width, height: 1)
        lineView.layer.borderWidth = 1
        lineView.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(lineView)
    }
    
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
//extension UIButton {
//    func createButton(frame: CGRect, color: UIColor, title: String) {
//        self.frame = frame
//        self.layer.cornerRadius = 10
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowRadius = 4
//        self.layer.masksToBounds = false
//        self.backgroundColor = color
//        self.setTitle(title, for: .normal)
//        self.setTitleColor(.white, for: .normal)
//    }
//}
