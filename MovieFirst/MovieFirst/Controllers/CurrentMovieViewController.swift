// CurrentMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Экран с выбранным фильмом

final class CurrentMovieViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let overviewText = "Overview"
    }

    // MARK: - Private Visual Properties

    private var imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .gray
        title = Constants.overviewText
        addSubview()
        setupConstraint()
    }

    private func addSubview() {
        view.addSubview(imageMovieImageView)
    }

    private func setupConstraint() {
        createImageMovieImageViewConstraint()
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageMovieImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageMovieImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: imageMovieImageView.widthAnchor)
        ])
    }
}
