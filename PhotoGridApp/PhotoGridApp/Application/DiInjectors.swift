//
//  DiInjectors.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(HeroesLayoutViewController.self) { service, controller in
            controller.viewModel = service.resolve(HeroesLayoutViewModelProtocol.self)
        }
        defaultContainer.register(HeroesLayoutViewModelProtocol.self) { service in
            HeroesLayoutViewModel(getHeroesUseCase: service.resolve(GetHeroesUseCaseProtocol.self)!)
        }
        defaultContainer.register(GetHeroesUseCaseProtocol.self) { service in
            GetHeroesUseCase(repository: service.resolve(HeroesRepositoryProtocol.self)!)
        }
        defaultContainer.register(HeroesRepositoryProtocol.self) { service in
            HeroesRepository(api: service.resolve(ApiClient.self)!)
        }
        defaultContainer.register(ApiClient.self) { _ in
            ApiClient()
        }
    }
}
