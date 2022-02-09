//
//  ChooseDoctorByProfession.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

class ChooseDoctorByProfession: UIViewController {
    
    private let professionId: Int
    private var doctors = [Doctor]()
    private var collectionView: UICollectionView?
    
    init(professionId: Int){
        self.professionId = professionId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор специалиста"
        configureCollectionView()
        
        DispatchQueue.main.async {
            let urlParameter = "&profession_id=" + String(self.professionId)
            let doctorsData = DataLoader(urlMethod: "&method=getUsers", urlParameter: urlParameter).doctorsData
            for item in doctorsData {
                let downloadImage = UIImageView()
                if item.avatar_small != nil {
                    downloadImage.downloaded(from: item.avatar_small!)
                } else {
                    downloadImage.image = UIImage(systemName: "person")
                }

                let doc = Doctor(id: item.id, name: item.name, profession: item.profession ?? [], profession_titles: item.profession_titles ?? "Доктор", image: downloadImage)
                
                self.doctors.append(doc)
            }
            self.collectionView?.reloadData()
        }
                
        view.backgroundColor = .white
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: RecordViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: RecordViewCell.identifire)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
    }
}

// MARK: --extension
extension ChooseDoctorByProfession: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DateRecordChoiceController(doctor: doctors[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChooseDoctorByProfession: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if doctors.isEmpty {
            return 0
        } else {
            return doctors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordViewCell.identifire, for: indexPath) as? RecordViewCell else { return UICollectionViewCell()}
        if doctors[indexPath.row].image.image == nil {
            collectionView.reloadData()
        }
        cell.professionLabel.text = doctors[indexPath.row].profession_titles
        cell.fullnameLabel.text = doctors[indexPath.row].name
        cell.profileImageView.image = doctors[indexPath.row].image.image
        return cell
    }
}

extension ChooseDoctorByProfession: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 40
        let height = width / 4
        return CGSize(width: width, height: height)
    }
}
