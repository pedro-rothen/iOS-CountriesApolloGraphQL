//
//  ContentView.swift
//  ApolloGraphQL
//
//  Created by Pedro on 31-07-24.
//

import SwiftUI
import Apollo
import CountryApi

class Network {
    static let shared = Network()
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://countries.trevorblades.com/")!
        return ApolloClient(url: url)
    }()
}

struct ContentView: View {
    @StateObject var viewModel = CountryViewModel()

    var body: some View {
        VStack {
            if let countries = viewModel.countries {
                List(countries, id: \.self) { country in
                    Text(country.name)
                }
            }
        }
        .padding()
    }
}

class CountryViewModel: ObservableObject {
    @Published var countries: [GetCountriesQuery.Data.Country]?

    init() {
        Network.shared.apollo.fetch(query: GetCountriesQuery()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.countries = result.data?.countries
                    print(result.errors)
                    print(result.asJSONDictionary())
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
