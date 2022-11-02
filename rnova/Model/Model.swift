//
//  Model.swift
//  rnova
//
//  Created by Александр Меренков on 10/12/21.
//

import Foundation
import UIKit

//  MARK: - Decodable

struct Services: Decodable {
    let id: Int
    let title: String
    let services_count: Int
}

struct SubService: Decodable {
    let service_id: Int
    let title: String
    let price: String
}

struct Doctors: Decodable {
    let id: Int
    let name: String
    let avatar_small: String?
    let profession: [String]?
    let profession_titles: String?
}

struct Professions: Decodable {
    let id: Int
    let name: String
    let doctor_name: String
}

struct Clinic: Decodable {
    let id: Int
    let title: String
    let mobile: String?
    let email: String?
    let address: String?
}

struct Schedule: Decodable {
    let date: String
    let time_start_short: String
    let clinic_id: Int
    let room: String
    let is_busy: Bool
}

//  MARK: - Informations

struct User {
    let lastname: String
    let firstname: String
    let surname: String
    let date: String
    let phoneNumber: String
    let password: String
}

struct Appointment {
    let doctor: String
    let profession: String
    let time: String
    let date: Date
    let clinic: String
    let comment: String
}

enum FlipCalendar {
    case left
    case right
}
