//
//  ApiError.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

enum ApiErrorType: String {
    case timeout = "Timeout"
    case generic = "Generic"
    case connection = "Connection"
    case notFound = "Not found"
    case custom = ""
}

struct ApiError: Error {
    private var type: ApiErrorType = .custom
    var code: String
    var message: String

    init(code: String = "", message: String) {
        self.message = message
        self.code = code
    }

    init (type: ApiErrorType = .custom) {
        self.message = type.rawValue
        self.code = ""
    }

    func asEntity() -> ErrorEntity {
        return ErrorEntity(message: self.message)
    }
}
