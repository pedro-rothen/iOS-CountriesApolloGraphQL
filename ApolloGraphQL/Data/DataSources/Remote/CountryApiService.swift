//
//  CountryApiService.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine
import CountryApi

protocol CountryApiService {
    func fetchCountries() -> AnyPublisher<[GetCountriesQuery.Data.Country], Error>
}
