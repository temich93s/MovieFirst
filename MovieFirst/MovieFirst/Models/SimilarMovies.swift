// SimilarMovies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Welcome

/// c
struct SimilarMovies: Codable {
    let results: [Result]
}

// MARK: - Result

/// d
struct Result: Codable {
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
