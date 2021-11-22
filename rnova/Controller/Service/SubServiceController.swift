//
//  SubServiceController.swift
//  rnova
//
//  Created by Александр Меренков on 11/18/21.
//

import UIKit

class SubServiceController: UIViewController {
    private let serviceId: Int
    private let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    private var subServicesData = [SubService]()
    
    private var collectionView: UICollectionView?
    
    init(id: Int) {
        self.serviceId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Выбор услуги"
        DispatchQueue.main.async {
            let urlParameter = "&category_id=" + String(self.serviceId)
            self.subServicesData = DataLoader(urlMethod: "&method=getServices", urlParameter: urlParameter).subServicesData
            self.collectionView?.reloadData()
        }
        
        configureCollectionView()
        
        view.backgroundColor = .white
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(UINib(nibName: SubServiceViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: SubServiceViewCell.identifire)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: --extension
extension SubServiceController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = subServicesData[indexPath.row].title
        let cost = subServicesData[indexPath.row].price
        let vc = ServiceCardController(name: name, cost: cost)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubServiceController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !subServicesData.isEmpty {
            return subServicesData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubServiceViewCell.identifire, for: indexPath) as? SubServiceViewCell else { return UICollectionViewCell() }
        if !subServicesData.isEmpty {
            cell.serviceNameLabel.text = subServicesData[indexPath.row].title
            cell.serviceCostLabel.text = subServicesData[indexPath.row].price + " руб."
        }
        return cell
    }
}

extension SubServiceController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 20
        let height = 90.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
}
