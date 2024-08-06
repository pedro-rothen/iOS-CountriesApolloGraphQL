//
//  ApolloGraphQLApp.swift
//  ApolloGraphQL
//
//  Created by Pedro on 31-07-24.
//

import SwiftUI

@main
struct ApolloGraphQLApp: App {
    @StateObject var coordinator = CountryCoordinator()
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
            NavigationStack(path: $coordinator.navigationPath) {
                ContentView(viewModel: viewModel, coordinator: coordinator)
                    .navigationDestination(for: Country.self) { country in
                        CountryDetailView(country: country)
                    }
            }
        }
    }
}
