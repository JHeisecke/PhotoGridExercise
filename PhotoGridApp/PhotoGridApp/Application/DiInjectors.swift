//
//  DiInjectors.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(ViewController.self) { _, _ in }
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
