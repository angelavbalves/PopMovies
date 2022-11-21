//
//  ValidateDecoderJSON.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 19/10/22.
//

@testable import PopMovies
import XCTest

class ValidateDecoderJSON: XCTestCase {

    var validJSON: Data!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let validURL = bundle.url(forResource: "valid", withExtension: "json")!

        validJSON = try! Data(contentsOf: validURL)
    }

    func test_givenDummyType_shouldDecode() {
        struct DummyType: Decodable {
            let int: Int
            let string: String
            let null: String?
        }

        let result: DummyType? = try? validJSON.decodeFromApi()
        XCTAssertNotNil(result)
    }

    func test_givenDummyType_shouldThrowError() {
        struct DummyType: Decodable {
            let int: Int
            let string: String
            let null: String
        }

        XCTAssertThrowsError(try validJSON.decodeFromApi() as DummyType)
    }
}
