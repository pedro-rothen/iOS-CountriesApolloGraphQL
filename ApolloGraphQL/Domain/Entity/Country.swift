//
//  Country.swift
//  ApolloGraphQL
//
//  Created by Pedro on 01-08-24.
//

import Foundation

struct Country: Equatable, Hashable {
    let name, flag, capital: String
    let states: [State]
}
