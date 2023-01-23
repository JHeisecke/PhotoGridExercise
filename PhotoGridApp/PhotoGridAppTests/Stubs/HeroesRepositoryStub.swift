//
//  HeroesRepositoryStub.swift
//  PhotoGridAppTests
//
//  Created by Javier Heisecke on 2022-06-05.
//

import Foundation
@testable import PhotoGridApp

class HeroesRepositoryStub: HeroesRepositoryProtocol {

    var hasError = false

    func getAllHeroes(success: @escaping (HeroesListResponse) -> Void, failure: @escaping (ApiError) -> Void) {
        if hasError {
            failure(ApiError(message: "Error"))
        } else {
            success(HeroesListResponse())
        }
    }

}
