//
//  PMServiceTests.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 18/10/22.
//

import XCTest
@testable import PopMovies

class PMServiceTests: XCTestCase {

    var sut: PMService!
    var apiClientMock: PopMoviesClientMock!

    override func setUp() {
        apiClientMock = PopMoviesClientMock()
        sut = .live(apiClientMock)
    }

    override func tearDown() {
        sut = nil
    }

    func test_whenGetMovies_shouldSuccessfullDecode() {
        guard let mockFile = Bundle(for: type(of: self)).url(forResource: "MovieResponse+Fixture", withExtension: "json") else {
            XCTFail("Mock file not found")
            return
        }

        apiClientMock.mockFile = mockFile
        sut = .live(apiClientMock)

        sut.getMovies(1) { result in
            guard case .success = result else {
                XCTFail("Result should be successfull")
                return
            }
        }
    }
}


