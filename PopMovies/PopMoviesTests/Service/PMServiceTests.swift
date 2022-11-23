//
//  PMServiceTests.swift
//  PopMoviesTests
//
//  Created by Angela Alves on 18/10/22.
//

@testable import PopMovies
import XCTest

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

    func test_whenGetGenres_shouldSucessfullDecode() {
        guard let mockFile = Bundle(for: type(of: self)).url(forResource: "GenreResponse+Fixture", withExtension: "json") else {
            XCTFail("Mock file not found")
            return
        }

        apiClientMock.mockFile = mockFile
        sut = .live(apiClientMock)

        sut.listGenres { result in
            guard case .success = result else {
                XCTFail("Result should be successfull")
                return
            }
        }
    }

    func test_getPopularMovies_shouldBuildExpectedEndpoint() {
        _ = sut.getMovies(1) { _ in }
        let endpoint = apiClientMock.endpoint

        XCTAssertEqual(endpoint?.host, "api.themoviedb.org")
        XCTAssertEqual(endpoint?.path, "/3/movie/popular")
        XCTAssertEqual(endpoint?.method, "get")
        XCTAssertEqual(
            endpoint?.query,
            [
                URLQueryItem(
                    name: "api_key",
                    value: "f66bae459e0caf58012f1645bfb5e772"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                )
            ]
        )
    }

    func test_similarMovies_shouldBuildExpectedEndpoint() {
        _ = sut.similarMovies(0, 1) { _ in }
        let endpoint = apiClientMock.endpoint

        XCTAssertEqual(endpoint?.host, "api.themoviedb.org")
        XCTAssertEqual(endpoint?.path, "/3/movie/\(0)/similar")
        XCTAssertEqual(endpoint?.method, "get")
        XCTAssertEqual(
            endpoint?.query,
            [
                URLQueryItem(
                    name: "api_key",
                    value: "f66bae459e0caf58012f1645bfb5e772"
                ),
                URLQueryItem(
                    name: "language", value: "en-US"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                )
            ]
        )
    }

    func test_searchMovies_shouldBuildExpectedEndpoint() {
        _ = sut.searchMovies(1, "Title") { _ in }
        let endpoint = apiClientMock.endpoint

        XCTAssertEqual(endpoint?.host, "api.themoviedb.org")
        XCTAssertEqual(endpoint?.path, "/3/search/movie")
        XCTAssertEqual(endpoint?.method, "get")
        XCTAssertEqual(
            endpoint?.query,
            [
                URLQueryItem(
                    name: "api_key",
                    value: "f66bae459e0caf58012f1645bfb5e772"
                ),
                URLQueryItem(
                    name: "language", value: "en-US"
                ),
                URLQueryItem(
                    name: "query", value: "Title"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                ),
                URLQueryItem(
                    name: "include_adult",
                    value: "false"
                )
            ]
        )
    }

    func test_listGenres_shouldBuildExpectedEndpoint() {
        _ = sut.listGenres { _ in }
        let endpoint = apiClientMock.endpoint

        XCTAssertEqual(endpoint?.host, "api.themoviedb.org")
        XCTAssertEqual(endpoint?.path, "/3/genre/movie/list")
        XCTAssertEqual(endpoint?.method, "get")
        XCTAssertEqual(
            endpoint?.query,
            [
                URLQueryItem(
                    name: "api_key",
                    value: "f66bae459e0caf58012f1645bfb5e772"
                ),
                URLQueryItem(
                    name: "language", value: "en-US"
                )
            ]
        )
    }

    func test_discoverMoviesByGenre_shouldBuildExpectedEndpoint() {
        _ = sut.listMoviesByGenre(1, 28) { _ in }
        let endpoint = apiClientMock.endpoint

        XCTAssertEqual(endpoint?.host, "api.themoviedb.org")
        XCTAssertEqual(endpoint?.path, "/3/discover/movie")
        XCTAssertEqual(endpoint?.method, "get")
        XCTAssertEqual(
            endpoint?.query,
            [
                URLQueryItem(
                    name: "api_key",
                    value: "f66bae459e0caf58012f1645bfb5e772"
                ),
                URLQueryItem(
                    name: "language", value: "en-US"
                ),
                URLQueryItem(
                    name: "sort_by",
                    value: "popularity.desc"
                ),
                URLQueryItem(
                    name: "include_adult",
                    value: "false"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                ),
                URLQueryItem(
                    name: "with_genres",
                    value: "28"
                ),
                URLQueryItem(
                    name: "with_watch_monetization_types",
                    value: "flatrate"
                )
            ]
        )
    }
}
