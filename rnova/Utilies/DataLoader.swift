//
//  DataLoader.swift
//  rnova
//
//  Created by Александр Меренков on 2/1/21.
//

import Foundation
//import Alamofire

public class  DataLoader {
    
    @Published var servicesData = [Services]()
    @Published var subServicesData = [SubService]()
    @Published var doctorsData = [Doctors]()
    @Published var professionsData = [Professions]()
    @Published var clinicsData = [Clinic]()
    @Published var scheduleData = [String: [Schedule]]()

    
    init(urlMethod:String, urlParameter: String) {
        self.urlMethod = urlMethod
        self.urlParameter = urlParameter
        load()
    }
    
    private let urlSourse = "https://rnova-widgets.testinmed.ru/dist/api.php?hacks=on"
//    private let urlMethod = "&method=getServiceCategories"
    private var urlMethod: String
    private var urlParameter: String
    
    func load() {
        let urlFull = urlSourse + urlMethod + urlParameter
        if let url = URL(string: urlFull) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                switch urlMethod {
                case "&method=getUsers":
                    let dataFromJson = try jsonDecoder.decode([Doctors].self, from: data)
                    self.doctorsData = dataFromJson
                case "&method=getServiceCategories":
                    let dataFromJson = try jsonDecoder.decode([Services].self, from: data)
                    self.servicesData = dataFromJson
                case "&method=getServices":
                    let dataFromJson = try jsonDecoder.decode([SubService].self, from: data)
                    self.subServicesData = dataFromJson
                case "&method=getProfessions":
                    let dataFromJson = try jsonDecoder.decode([Professions].self, from: data)
                    self.professionsData = dataFromJson
                case "&method=getClinics":
                    let dataFromJson = try jsonDecoder.decode([Clinic].self, from: data)
                    self.clinicsData = dataFromJson
                case "&method=getSchedule":
                    let dataFromJson: [String: [Schedule]] = try jsonDecoder.decode([String: [Schedule]].self, from: data)
                    self.scheduleData = dataFromJson
                default:
                    return
                }
            }
            catch {
                print("There was an error finding in the data! ")
            }
        }
                
    }
    
}



