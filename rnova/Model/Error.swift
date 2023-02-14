//
//  Error.swift
//  rnova
//
//  Created by Александр Меренков on 14.02.2023.
//

import Foundation

enum RequestStatus<T> {
    case success(T)
    case error(Error)
}

enum NetworkError: Error {
    case notFound
    case badRequest
    case serverError
    case otherError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("Страница не найдена", comment: "")
        case .badRequest:
            return NSLocalizedString("Неправильный запрос", comment: "")
        case .serverError:
            return NSLocalizedString("Сервер временно недоступен. Попробуйте позже.", comment: "")
        case .otherError:
            return NSLocalizedString("Ошибка. Попробуйте снова.", comment: "")
        }
    }
}

enum CoreDataError: Error {
    case somethingError
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .somethingError:
            return NSLocalizedString("Ошибка. Попробуйте снова.", comment: "")
        }
    }
}
