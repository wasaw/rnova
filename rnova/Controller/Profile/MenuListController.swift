//
//  MenuListController.swift
//  rnova
//
//  Created by Александр Меренков on 12/6/21.
//

import UIKit

class MenuListController: UITableViewController {
    
//    MARK: - Properties
    
    private let listItemsName = ["Профиль", "Визиты", "Выход"]
    private let listVCItems = [ProfileController(), VisitsController(), ExitController()]
    private let listImageItems = ["person.fill", "note.text", "rectangle.portrait.and.arrow.right"]

//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.register(MenuListViewCell.self, forCellReuseIdentifier: MenuListViewCell.identifire)
        tableView.backgroundColor = .white
    }

//  MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItemsName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuListViewCell.identifire, for: indexPath) as? MenuListViewCell else { return UITableViewCell() }
        cell.setInformation(name: listItemsName[indexPath.row], image: listImageItems[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(listVCItems[indexPath.row], animated: false)
    }

}
