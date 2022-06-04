//
//  HeroesRepository.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

struct HeroesRepository: HeroesRepositoryProtocol {
    func getAllHeroes(success: @escaping (HeroesListResponse) -> Void, failure: @escaping (ApiError) -> Void) {
        ApiClient.request(
            verb: .get,
            route: .fetchPhotos,
            encoding: .json) { (response: HeroesListResponse) in
                success(response)
            } failure: { error in
                failure(error)
            }
    }
}
