//
//  DatabaseService.swift
//  rnova
//
//  Created by Александр Меренков on 12/1/21.
//

import CoreData
import UIKit

final class DatabaseService {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    func registration(user: User, completion: @escaping(RequestStatus<Bool>) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let result = try context.fetch(fetchRequest)
            
            if (result.first as? NSManagedObject) != nil {
                completion(.success(false))
            } else {
                guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: context) else { return }
                let newPerson = NSManagedObject(entity: entity, insertInto: context)
                
                newPerson.setValue(user.firstname, forKey: "firstname")
                newPerson.setValue(user.surname, forKey: "surname")
                newPerson.setValue(user.lastname, forKey: "lastname")
                newPerson.setValue(user.date, forKey: "date")
                newPerson.setValue(user.phoneNumber, forKey: "phone")
                newPerson.setValue(true, forKey: "login")
                newPerson.setValue(user.password, forKey: "password")
                do {
                    try context.save()
                    completion(.success(true))
                } catch {
                    completion(.error(CoreDataError.somethingError))
                }
            }
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
    
    func getPersonInformation(completion: @escaping(RequestStatus<User>) -> Void) {
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
                        phoneNumber: data.value(forKey: "phone") as? String ?? "",
                        password: data.value(forKey: "password") as? String ?? "")
                    completion(.success(user))
                }
            }
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
    
    func checkLogIn(completion: @escaping(RequestStatus<Bool>) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            if let user = result.first as? NSManagedObject {
                let checkLogIn = user.value(forKey: "login") as? Bool ?? false
                if checkLogIn {
                    completion(.success(true))
                }
            }
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
        completion(.success(false))
    }
    
    func saveDoctorAppointment(ticket: Appointment, completion: @escaping(RequestStatus<Bool>) -> Void) {
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
            completion(.success(true))
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
    
    func loadDoctorAppointment(completion: @escaping(RequestStatus<[Appointment]>) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        do {
            let result = try context.fetch(fetchRequest)
            var ticket = [Appointment]()
            for data in result {
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
            completion(.success(ticket))
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
    
    func login(phoneNumber: String, password: String, completion: @escaping(RequestStatus<Bool>) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        do {
            let result = try context.fetch(fetchRequest)
            guard let user = result.first as? NSManagedObject else { return }
            
            let phoneBD = user.value(forKey: "phone") as? String ?? ""
            let passBD = user.value(forKey: "password") as? String ?? ""
            if phoneNumber == phoneBD && password == passBD {
                user.setValue(true, forKey: "login")
                try context.save()
                completion(.success(true))
            }
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
    
    func exit(completion: @escaping(RequestStatus<Bool>) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let user = result.first as? NSManagedObject else { return }
            user.setValue(false, forKey: "login")
            try context.save()
            completion(.success(true))
        } catch {
            completion(.error(CoreDataError.somethingError))
        }
    }
}
