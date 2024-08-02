//
//  GetCountriesUseCaseImpl.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine

class GetCountriesUseCaseImpl: GetCountriesUseCase {
    let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Country], any Error> {
        return repository.getCountries()
    }
}
