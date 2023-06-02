//
//  MenuViewController.swift
//  rnova
//
//  Created by Александр Меренков on 15.02.2023.
//

import UIKit

enum MenuOption: String, CaseIterable {
    case profile = "Профиль"
    case visits = "Визиты"
    case logout = "Выход"
}

private enum Constants {
    static let tablePaddingTop: CGFloat = 39
}

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menu: MenuOption)
}

final class MenuViewController: UIViewController {
    private let reuseIdentifire = "tableCell"
    
//    MARK: - Properties
    
    weak var delegate: MenuViewControllerDelegate?
    
    private var tableView: UITableView?
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        view.backgroundColor = .systemOrange
    }
    
//    MARK: - Helpers
    
    private func configureUI() {
        tableView = UITableView(frame: .zero)
        guard let tableView = tableView else { return }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifire)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.anchor(leading: view.leadingAnchor,
                         top: view.safeAreaLayoutGuide.topAnchor,
                         trailing: view.trailingAnchor,
                         bottom: view.bottomAnchor,
                         paddingTop: Constants.tablePaddingTop)
    }
}

//  MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.didSelect(menu: MenuOption.allCases[indexPath.row])
    }
}

//  MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifire, for: indexPath)
        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
        return cell
    }
}
