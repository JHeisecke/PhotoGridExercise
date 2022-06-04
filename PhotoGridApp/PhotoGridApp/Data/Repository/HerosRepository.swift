//
//  HerosRepository.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

struct HerosRepository: HerosRepositoryProtocol {
    func getAllHeroes(completion: @escaping (HerosListResponse) -> Void, failure: @escaping (ApiError) -> Void) {
        ApiClient.request(
            verb: .get,
            route: .fetchPhotos,
            encoding: .json) { (response: HerosListResponse) in
                completion(response)
            } failure: { error in
                failure(error)
            }

    }
}
