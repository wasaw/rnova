//
//  ContainerSideMenu.swift
//  rnova
//
//  Created by Александр Меренков on 15.02.2023.
//

import UIKit

enum MenuState {
    case open
    case close
}

final class ContainerSideMenu: UIViewController {
    
//    MARK: - Properties
        
    private let menuVC = MenuViewController()
    private var homeVC = ProfileController()
    private var navVC: UINavigationController?
    private var currentVC: UIViewController = ProfileController()
    private lazy var blackView = UIView()
    private lazy var xOrigin = view.frame.width - 80
    
    private var menuState: MenuState = .close
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC()
    }
    
//    MARK: - Helpers
    
    private func addChildVC() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        menuVC.delegate = self
        
        let navVC = UINavigationController(rootViewController: homeVC)
        homeVC.delegate = self
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    private func toggle() {
        switch menuState {
        case .open:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
                self.blackView.alpha = 0
                self.menuState = .close
            }
        case .close:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.xOrigin
                self.blackView.frame = CGRect(x: self.xOrigin, y: 0, width: 80, height: self.view.frame.height)
                self.blackView.alpha = 1
                self.menuState = .open
            }
        }
    }
    
    private func updateContainer(vc: UIViewController) {
        currentVC.view.removeFromSuperview()
        currentVC.didMove(toParent: nil)
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        currentVC = vc
    }
    
//  MARK: - Selectors
    
    @objc private func dismissMenu() {
        toggle()
    }
}

//  MARK: - MenuViewControllerDelegate

extension ContainerSideMenu: MenuViewControllerDelegate {
    func didSelect(menu: MenuOption) {
        toggle()
        switch menu {
        case .profile:
            self.updateContainer(vc: ProfileController())
        case .visits:
            self.updateContainer(vc: VisitsController())
        case .logout:
            let alert = UIAlertController(title: nil, message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
                let databaseService = DatabaseService.shared
                DispatchQueue.main.async {
                    databaseService.exit { result in
                        switch result {
                        case .success(_):
                            self.updateContainer(vc: ProfileController())
                        case .error(let error):
                            self.alert(with: "Ошибка", and: error.localizedDescription)
                        }
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

//  MARK: - ProfileViewControllerDelegate

extension ContainerSideMenu: ProfileControllerDelegate {
    func didTapMenuButton() {
        toggle()
    }
}
