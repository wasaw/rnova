//
//  DatabaseService.swift
//  rnova
//
//  Created by Александр Меренков on 12/1/21.
//

import CoreData
import UIKit

class DatabaseService {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    func registration(user: User) {
        let context = appDelegate.persistentContainer.viewContext
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let result = try context.fetch(fetchRequest)
            
            if (result.first as? NSManagedObject) != nil {
                let alert = UIAlertController(title: "Внимание", message: "Вы уже зарегистрировались на этом устройстве", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            } else {
                guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
                let newPerson = NSManagedObject(entity: entity, insertInto: context)
                
                newPerson.setValue(user.firstname, forKey: "firstname")
                newPerson.setValue(user.surname, forKey: "surname")
                newPerson.setValue(user.lastname, forKey: "lastname")
                newPerson.setValue(user.date, forKey: "date")
                newPerson.setValue(user.phoneNumber, forKey: "phone")
                newPerson.setValue(true, forKey: "login")
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getPersonInformation() -> User {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                if let data = data as? NSManagedObject {
                    let user = User(
                        lastname: data.value(forKey: "lastname") as? String ?? "",
                        firstname: data.value(forKey: "firstname") as? String ?? "",
                        surname: data.value(forKey: "surname") as? String ?? "",
                        date: data.value(forKey: "date") as? String ?? "",
                        phoneNumber: data.value(forKey: "phone") as? String ?? "")
                    return user
                }
            }
        } catch let error as NSError {
            print(error)
        }
        
        return User(lastname: "", firstname: "", surname: "", date: "", phoneNumber: "")
    }
    
    func checkLogIn() -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            if let user = result.first as? NSManagedObject {
                let checkLogIn = user.value(forKey: "login") as? Bool ?? false
                if checkLogIn {
                    return true
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return false
    }
}
