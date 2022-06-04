//
//  HeroesRepository.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

struct HeroesRepository: HeroesRepositoryProtocol {

    var api: ApiClient?

    init(api: ApiClient) {
        self.api = api
    }

    func getAllHeroes(success: @escaping (HeroesListResponse) -> Void, failure: @escaping (ApiError) -> Void) {
        api?.request(
            verb: .get,
            route: .fetchPhotos,
            encoding: .default) { (response: HeroesListResponse) in
                success(response)
            } failure: { error in
                failure(error)
            }
    }
}
