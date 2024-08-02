//
//  CountryRepositoryImpl.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine

class CountryRepositoryImpl: CountryRepository {
    let remoteDataSource: CountryApiService

    init(remoteDataSource: CountryApiService) {
        self.remoteDataSource = remoteDataSource
    }

    func getCountries() -> AnyPublisher<[Country], Error> {
        return remoteDataSource
            .fetchCountries()
            .map {
                $0.map { Country(name: $0.name, flag: $0.emoji, capital: $0.capital ?? "🙃") }
            }.eraseToAnyPublisher()
    }
}
