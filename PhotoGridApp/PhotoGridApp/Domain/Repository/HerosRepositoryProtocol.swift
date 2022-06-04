//
//  HerosRepositoryProtocol.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

protocol HerosRepositoryProtocol {
    // @escaping is used to inform callers of function that the closure might be stored or otherwise outlive the scope of the receiving function
    func getAllHeroes(completion: @escaping (HerosListResponse) -> Void, failure: @escaping (ApiError) -> Void)
}
