//
//  ApolloGraphQLApp.swift
//  ApolloGraphQL
//
//  Created by Pedro on 31-07-24.
//

import SwiftUI

@main
struct ApolloGraphQLApp: App {
    let viewModel: CountriesViewModel

    init() {
        let apiClient = CountryNetworkApolloClient()
        let countryRemoteDataSource = CountryApiServiceImpl(client: apiClient)
        let countryRepository = CountryRepositoryImpl(remoteDataSource: countryRemoteDataSource)
        let getCountriesUseCase = GetCountriesUseCaseImpl(repository: countryRepository)
        viewModel = CountriesViewModel(getCountriesUseCase: getCountriesUseCase)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
