//
//  HeroesViewModel.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import Bond

protocol HeroesLayoutViewModelProtocol {
    var heroes: Observable<Heroes?> { get }
    var error: Observable<ErrorEntity?> { get }

    var getHeroesUseCase: GetHeroesUseCaseProtocol? { get }

    func getHeroes()
}

struct HeroesLayoutViewModel: HeroesLayoutViewModelProtocol {
    var heroes: Observable<Heroes?> = Observable(nil)
    var error: Observable<ErrorEntity?> = Observable(nil)

    var getHeroesUseCase: GetHeroesUseCaseProtocol?

    init(getHeroesUseCase: GetHeroesUseCaseProtocol) {
        self.getHeroesUseCase = getHeroesUseCase
        getHeroes()
    }

    func getHeroes() {
        getHeroesUseCase?.getHeroes(
            completion: { response in
                self.heroes.value = response
            }, error: { error in
                self.error.value = error
            }
        )
    }
}
