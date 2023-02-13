//
//  NetworkService.swift
//  rnova
//
//  Created by Александр Меренков on 10.02.2023.
//

import Foundation

enum RequstMethod: String {
    case users = "&method=getUsers"
    case categories = "&method=getServiceCategories"
    case services = "&method=getServices"
    case professions = "&method=getProfessions"
    case clinics = "&method=getClinics"
    case schedule = "&method=getSchedule"
}

final class NetworkService {
    static let shared = NetworkService()
    
//    MARK: - Properties
    
    private let config = NetworkConfiguration()
    private let configuretion = URLSessionConfiguration.default
    private lazy var urlSession: URLSession = {
        let urlSession = URLSession(configuration: configuretion)
        return urlSession
    }()
    
    
//    MARK: - Helpers
    
    func request<T: Decodable>(method: RequstMethod, category: String = "", completion: @escaping(RequestStatus<T?>) -> Void) {
        let fullRequest = config.getUrl() + method.rawValue + category
        guard let url = URL(string: fullRequest) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    let decodeData = JsonHelpers.shared.decode(data: data, T.self)
                    completion(.success(decodeData))
                }
            }
        }
        task.resume()
    }
    
}
