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
    
    func saveDoctorAppointment(ticket: Appointment) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Record", in: context) else { return }
        let newRecord = NSManagedObject(entity: entity, insertInto: context)
        
        newRecord.setValue(ticket.doctor, forKey: "doctor")
        newRecord.setValue(ticket.time, forKey: "time")
        newRecord.setValue(ticket.date, forKey: "date")
        newRecord.setValue(ticket.clinic, forKey: "clinic")
        newRecord.setValue(ticket.comment, forKey: "comment")
        newRecord.setValue(ticket.profession, forKey: "profession")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let user = result.first as? NSManagedObject else { return }
            newRecord.setValue(user, forKey: "owner")
            try context.save()
            print("DEBUG: Successfully")
        } catch let error as NSError {
            print(error)
        }
    }
    
    func loadDoctorAppointment() -> [Appointment] {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        do {
            let result = try context.fetch(fetchRequest)
            var ticket = [Appointment]()
            for data in result {
                print("DEBUG: \(result.count)")
                if let data = data as? NSManagedObject {
                    let ticketTemp = Appointment(
                        doctor: data.value(forKey: "doctor") as? String ?? "",
                        profession: data.value(forKey: "profession") as? String ?? "",
                        time: data.value(forKey: "time") as? String ?? "",
                        date: data.value(forKey: "date") as? Date ?? Date(timeIntervalSince1970: 0),
                        clinic: data.value(forKey: "clinic") as? String ?? "",
                        comment: data.value(forKey: "comment") as? String ?? "Нет комментария")
                    ticket.append(ticketTemp)
                }
            }
            return ticket
        } catch let error as NSError {
            print(error)
        }
//        return [Appointment(clinic: "", comment: "", time: "", date: Date(timeIntervalSince1970: 0), doctor: "")]
        return [Appointment(doctor: "", profession: "", time: "", date: Date(timeIntervalSince1970: 0), clinic: "", comment: "")]
    }
}
