//
//  HeroesViewModel.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import RxSwift

protocol HeroesLayoutViewModelProtocol {
    var getHeroesUseCase: GetHeroesUseCaseProtocol? { get }

    func getHeroes()
}

struct HeroesLayoutViewModel: HeroesLayoutViewModelProtocol {

    var getHeroesUseCase: GetHeroesUseCaseProtocol?

    func getHeroes() {
        getHeroesUseCase?.getHeroes(
            completion: { response in
                print(response)
            }, error: { error in
                print(error)
            }
        )
    }
}
