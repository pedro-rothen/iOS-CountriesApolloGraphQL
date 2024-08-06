//
//  CountryDetailView.swift
//  ApolloGraphQL
//
//  Created by Pedro on 05-08-24.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text(country.flag)
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                Text(country.name)
                    .font(.title)
                Text(country.capital)
                    .font(.subheadline)
                LazyVStack {
                    ForEach(country.states, id: \.name) { state in
                        Text(state.name)
                    }
                }
            }
        }
    }
}

#Preview {
    CountryDetailView(country: Country(name: "asdjn", flag: "ads", capital: "asd", states: []))
}
