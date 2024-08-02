//
//  GetCountriesUseCase.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine

protocol GetCountriesUseCase {
    func execute() -> AnyPublisher<[Country], Error>
}
