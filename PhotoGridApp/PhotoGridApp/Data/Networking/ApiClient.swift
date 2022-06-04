//
//  ApiClient.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import Alamofire
import Sniffer

typealias FailureCallback = (ApiError) -> Void
typealias GenericDictionary = [String: Any]

enum Encoding {
    case `default`
    case json
    case query
    var alamofire: ParameterEncoding {
        switch self {
        case .default:
            return URLEncoding.default
        case .json:
            return JSONEncoding.default
        case .query:
            return URLEncoding.queryString
        }
    }
}

class ApiClient {
    class func request<T: Codable>(
        verb: HTTPMethod = .get,
        route: Endpoints,
        parameters: [String: Any] = [:],
        headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ],
        encoding: Encoding = .default,
        success: @escaping (T) -> Swift.Void,
        failure: ((ApiError) -> Swift.Void)? = nil
    ) {
        // Has connection?
        guard NetworkReachabilityManager()?.isReachable == true else {
            failure?(ApiError(type: .connection))
            return
        }
        BaseSessionManager.shared
            .request(route.endpoint,
                     method: verb,
                     parameters: parameters,
                     encoding: encoding.alamofire,
                     headers: headers)
            .validate() // Validates the response status code by default 200..<299
            .response { response in
                switch response.result {
                case .success(let data):
                    guard response.error == nil else {
                        // We got a timeout
                        if response.error?._code == NSURLErrorTimedOut {
                            failure?(ApiError(type: .timeout))
                        } else {
                            failure?(ApiError(type: .generic))
                        }
                        return
                    }
                    guard let data = data else {
                        failure?(ApiError())
                        return
                    }
                    do {
                        let decoded = try JSONDecoder().decode(T.self, from: data)
                        success(decoded)
                    } catch let error {
                        let apiError = ApiError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 404:
                        let apiError = ApiError(type: .notFound)
                        failure?(apiError)
                    default:
                        let apiError = ApiError(message: error.localizedDescription)
                        failure?(apiError)
                    }
                }
            }
    }
}

class BaseSessionManager: Session {
    static let shared: BaseSessionManager = {
        let configuration = URLSessionConfiguration.default
        // enables logger
        Sniffer.enable(in: configuration)
        configuration.timeoutIntervalForRequest = 60
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let manager = BaseSessionManager(configuration: configuration)
        return manager
    }()
}
