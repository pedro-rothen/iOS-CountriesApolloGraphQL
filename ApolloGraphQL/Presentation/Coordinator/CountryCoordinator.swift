//
//  CountryCoordinator.swift
//  ApolloGraphQL
//
//  Created by Pedro on 05-08-24.
//

import Foundation

@MainActor
class CountryCoordinator: ObservableObject {
    @Published var navigationPath: [Country] = []

    func showCountryDetail(country: Country) {
        navigationPath.append(country)
    }
}
