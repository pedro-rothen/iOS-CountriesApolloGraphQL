//
//  ContentView.swift
//  ApolloGraphQL
//
//  Created by Pedro on 31-07-24.
//

import SwiftUI
import Apollo
import CountryApi
import Combine

struct ContentView: View {
    @StateObject var viewModel: CountryViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    if let countries = viewModel.countries {
                        ForEach(countries, id: \.name) { country in
                            NavigationLink(destination: {
                                Detail(country: country)
                            }, label: {
                                Text(country.flag)
                                    .font(.largeTitle)
                                    .frame(width: 100, height: 100)
                            })
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.getCountries()
        }
        .padding()
    }

    @ViewBuilder
    func Detail(country: Country) -> some View {
        ScrollView {
            LazyVStack {
                Text(country.flag)
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                Text(country.name)
                    .font(.title)
                Text(country.capital)
                    .font(.subheadline)
            }
        }
    }
}

@MainActor
class CountryViewModel: ObservableObject {
    let getCountriesUseCase: GetCountriesUseCase
    var cancellables = Set<AnyCancellable>()

    @Published var countries: [Country]?

    init(getCountriesUseCase: GetCountriesUseCase) {
        self.getCountriesUseCase = getCountriesUseCase
    }

    func getCountries() {
        getCountriesUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                }
            }, receiveValue: { [weak self] in
                self?.countries = $0
            }).store(in: &cancellables)
    }
}

#Preview {
    let apiClient = CountryNetworkApolloClient()
    let countryRemoteDataSource = CountryApiServiceImpl(client: apiClient)
    let countryRepository = CountryRepositoryImpl(remoteDataSource: countryRemoteDataSource)
    let getCountriesUseCase = GetCountriesUseCaseImpl(repository: countryRepository)
    let viewModel = CountryViewModel(getCountriesUseCase: getCountriesUseCase)
    return ContentView(viewModel: viewModel)
}
// ./apollo-ios-cli fetch-schema
// ./apollo-ios-cli generate
