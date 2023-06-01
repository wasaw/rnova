//
//  ChooseDoctorByProfession.swift
//  rnova
//
//  Created by Александр Меренков on 10/29/21.
//

import UIKit

private enum Constants {
    static let collectionViewPaddingTop: CGFloat = 20
}

final class ChooseDoctorByProfession: UIViewController {
    
//    MARK: - Properties
    
    private let professionId: Int
    private var doctors = [Doctor]()
    private var collectionView: UICollectionView?
    
//    MARK: - Lifecycle
    
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
        loadInformation()
        configureCollectionView()
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func loadInformation() {
        DispatchQueue.main.async {
            let urlParameter = "&profession_id=" + String(self.professionId)
            NetworkService.shared.request(method: .users, category: urlParameter) { (result: RequestStatus<[Doctors]?>) in
                switch result {
                case .success(let answer):
                    guard let answer = answer else { return }
                    for item in answer {
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
                case .error(let error):
                    self.alert(with: "Ошибка", and: error.localizedDescription)
                }
            }            
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DoctorViewCell.self, forCellWithReuseIdentifier: DoctorViewCell.identifire)
        view.addSubview(collectionView)
        collectionView.anchor(left: view.leftAnchor,
                              top: view.safeAreaLayoutGuide.topAnchor,
                              right: view.rightAnchor,
                              bottom: view.bottomAnchor,
                              paddingTop: Constants.collectionViewPaddingTop)
        collectionView.backgroundColor = .white
    }
}

// MARK: - Extensions

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorViewCell.identifire, for: indexPath) as? DoctorViewCell else { return UICollectionViewCell()}
        if doctors[indexPath.row].image.image == nil {
            collectionView.reloadData()
        }
        cell.setInformation(doctors[indexPath.item])

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
