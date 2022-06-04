//
//  Endpoints.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import Foundation

enum Endpoints: String, CaseIterable {
    case fetchPhotos = "https://bitbucket.org/consultr/superhero-json-api/raw/4b787c39fcbfd8d069339de94bf8f3a6bda69f3e/superheros.json"
    var endpoint: String {
        return self.rawValue
    }
}
