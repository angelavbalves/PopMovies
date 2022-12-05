//
//  MoviesCoreDataTests.swift
//  PopMovies
//
//  Created by Angela Alves on 13/10/22.
//

import CoreData
@testable import PopMovies
import XCTest

final class MoviesCoreDataTests: XCTestCase {

    var sut: FavoriteMoviesDataSource!
    var coreDataStackMock: CoreDataStackMock!

    override func setUp() {
        coreDataStackMock = .init()
        sut = .init(
            coreDataStack: coreDataStackMock,
            managedObjectContext: coreDataStackMock.mainContext
        )
    }

    override func tearDown() {
        sut = nil
        coreDataStackMock = nil
    }

    func test_givenMovie_whenSaveMovie_shouldSaveMovie() {
        // given
        let input: MovieItem = .stub(
            id: 0,
            title: "title",
            overview: "description",
            posterPath: "poster_path",
            releaseDate: "release_date"
        )
        // when
        sut.save(movie: input)
        // then
        let movies = sut.fetchAllMovies()
        XCTAssertEqual(movies.count, 1)
        let result = movies.first
        XCTAssertEqual(result?.id, input.id)
        XCTAssertEqual(result?.title, input.title)
        XCTAssertEqual(result?.overview, input.overview)
        XCTAssertEqual(result?.posterPath, input.posterPath)
        XCTAssertEqual(result?.releaseDate, input.releaseDate)
    }

    func test_givenMovies_whenFetchMovies_shouldReturnAllMovies() {
        // Given
        let movieOne: MovieItem = .stub(id: 0)
        let movieTwo: MovieItem = .stub(id: 1)
        let movieThree: MovieItem = .stub(id: 2)

        // Save
        sut.save(movie: movieOne)
        sut.save(movie: movieTwo)
        sut.save(movie: movieThree)

        // When
        let movies = sut.fetchAllMovies()

        // Then
        XCTAssertEqual(movies.count, 3)
        XCTAssertTrue(movies.contains(movieOne))
        XCTAssertTrue(movies.contains(movieTwo))
        XCTAssertTrue(movies.contains(movieThree))
    }

    func test_givenMovie_whenRemoveFavoriteMovie_shouldRemoveMovie() {

        // Given
        let input: MovieItem = .stub(id: 0)
        sut.save(movie: input)

        // When
        sut.removeMovie(for: input.id)

        // Then
        let movies = sut.fetchAllMovies()
        XCTAssertEqual(movies.count, 0)
    }

    func test_givenMovie_whenAllRemoveFavoriteMovie_shouldRemoveAllMovie() {

        // Given
        let input: MovieItem = .stub(id: 0)
        let inputTwo: MovieItem = .stub(id: 1)
        let inputThree: MovieItem = .stub(id: 2)
        let inputFour: MovieItem = .stub(id: 3)
        sut.save(movie: input)
        sut.save(movie: inputTwo)
        sut.save(movie: inputThree)
        sut.save(movie: inputFour)

        // When
        sut.removeAllFavoriteMovies()

        // Then
        let movies = sut.fetchAllMovies()
        XCTAssertEqual(movies.count, 0)
    }
}
