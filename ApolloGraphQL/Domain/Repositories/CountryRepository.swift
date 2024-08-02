//
//  CountryRepository.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine

protocol CountryRepository {
    func getCountries() -> AnyPublisher<[Country], Error>
}
