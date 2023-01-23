//
//  DiInjectors.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import SwinjectStoryboard
import Swinject

struct DIContainer {
    static func setup(_ container: Container) {
        container.storyboardInitCompleted(SplashViewController.self) { _, _ in }
        container.storyboardInitCompleted(HeroesLayoutViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(HeroesLayoutViewModelProtocol.self)
        }
        container.register(HeroesLayoutViewModelProtocol.self) { service in
            HeroesLayoutViewModel(getHeroesUseCase: service.resolve(GetHeroesUseCaseProtocol.self)!)
        }
        container.register(GetHeroesUseCaseProtocol.self) { service in
            GetHeroesUseCase(repository: service.resolve(HeroesRepositoryProtocol.self)!)
        }
        container.register(HeroesRepositoryProtocol.self) { service in
            HeroesRepository(api: service.resolve(ApiClient.self)!)
        }
        container.register(ApiClient.self) { _ in
            ApiClient()
        }
    }
}
