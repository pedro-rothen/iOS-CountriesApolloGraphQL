//
//  CountryApiServiceImpl.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation
import Combine
import CountryApi
import Apollo

class CountryApiServiceImpl: CountryApiService {
    let client: CountryApiClient

    init(client: CountryApiClient) {
        self.client = client
    }

    func fetchCountries() -> AnyPublisher<[GetCountriesQuery.Data.Country], Error> {
        return client.fetchCountries()
    }
}

protocol CountryApiClient {
    func fetchCountries() -> AnyPublisher<[GetCountriesQuery.Data.Country], Error>
}

class CountryNetworkApolloClient: CountryApiClient {
    private lazy var client: ApolloClient? = {
        guard let url = URL(string: "https://countries.trevorblades.com/") else {
            return nil
        }
        return ApolloClient(url: url)
    }()

    func fetchCountries() -> AnyPublisher<[GetCountriesQuery.Data.Country], any Error> {
        return Future { [weak self] promise in
            guard let client = self?.client else {
                promise(.failure(ApolloClientError.invalidClient))
                return
            }
            client.fetch(query: GetCountriesQuery()) { result in
                switch result {
                case .success(let result):
                    guard let data = result.data?.countries else {
                        promise(.failure(ApolloClientError.invalidData(result.errors)))
                        return
                    }
                    promise(.success(data))
                case .failure(let failure):
                    promise(.failure(failure))
                }
            }
        }.eraseToAnyPublisher()
    }
}

enum ApolloClientError: Error {
    case invalidClient
    case invalidData([GraphQLError]?)
}
