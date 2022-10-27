// SimilarMovieCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - SimilarMovieCollectionViewCell

/// Ячейка с похожим фильмом
final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Visual Properties

    private let imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageMovieImageView)
        createImageMovieImageViewConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureSimilarMovieCollectionViewCell(dataImage: Data) {
        imageMovieImageView.image = UIImage(data: dataImage)
    }

    // MARK: - Private Methods

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageMovieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageMovieImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageMovieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
