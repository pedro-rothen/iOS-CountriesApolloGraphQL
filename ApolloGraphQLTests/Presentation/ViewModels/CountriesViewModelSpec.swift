//
//  CountriesViewModelSpec.swift
//  ApolloGraphQLTests
//
//  Created by Pedro on 02-08-24.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import ApolloGraphQL

class CountriesViewModelSpec: AsyncSpec {

    override class func spec() {
        var viewModel: CountriesViewModel!
        var mockGetCountriesUseCase: MockGetCountriesUseCase!

        describe("CountriesViewModel") {
            beforeEach {
                mockGetCountriesUseCase = MockGetCountriesUseCase()
                viewModel = await CountriesViewModel(getCountriesUseCase: mockGetCountriesUseCase)
            }

            context("when getCountries is called") {
                it("updates countries from remote ones") {
                    // Arrange
                    let countries = [Country(name: "Chile", flag: "🇨🇱", capital: "Santiago", states: [])]
                    mockGetCountriesUseCase.stub = Just(countries)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()

                    // Act
                    // Workaround to evaluate from MainActor object
                    var viewModelCountries: [Country]?
                    await viewModel.getCountries()
                    await viewModelCountries = viewModel.countries

                    // Assert
                    await expect(viewModelCountries).toEventually(equal(countries))
                }
            }
        }
    }

    class MockGetCountriesUseCase: GetCountriesUseCase {
        var stub: AnyPublisher<[Country], Error>!

        func execute() -> AnyPublisher<[Country], Error> {
            return stub
        }
    }
}
