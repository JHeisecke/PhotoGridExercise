//
//  GetHeroesUseCase.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

protocol GetHeroesUseCaseProtocol {
    func getHeroes(completion: @escaping (Heroes) -> Void, error: @escaping (ErrorEntity) -> Void)
}

struct GetHeroesUseCase: GetHeroesUseCaseProtocol {

    private var repository: HeroesRepositoryProtocol?

    init(repository: HeroesRepositoryProtocol) {
        self.repository = repository
    }

    func getHeroes(completion: @escaping (Heroes) -> Void, error: @escaping (ErrorEntity) -> Void) {
        repository?.getAllHeroes(
            success: { response in
                var heroes: Heroes = []
                response.forEach { hero in
                    heroes.append(hero.asEntity())
                }
                completion(heroes)
            },
            failure: { errorResponse in
                error(errorResponse.asEntity())
            }
        )
    }
}
