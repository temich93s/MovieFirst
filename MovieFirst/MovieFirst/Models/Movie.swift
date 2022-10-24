// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Movie

/// Movie
struct Movie: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?
}

// MARK: - Result

/// Result
struct Result: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
