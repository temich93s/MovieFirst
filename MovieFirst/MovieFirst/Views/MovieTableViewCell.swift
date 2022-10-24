// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Ячейка с фильмом

final class MovieTableViewCell: UITableViewCell {
    // MARK: - Private Visual Properties

    private var nameMovieLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()

    private var descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        return label
    }()

    private var dateMovieLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        return label
    }()

    private var scoreMovieLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .cyan
        return label
    }()

    private var imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        addSubview()
        setupConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    func configureMovieTableViewCell(
        imageMovieName: String,
        nameMovie: String,
        descriptionMovie: String,
        dateMovie: String,
        scoreMovie: String
    ) {
        imageMovieImageView.image = UIImage(named: imageMovieName)
        nameMovieLabel.text = nameMovie
        descriptionMovieLabel.text = descriptionMovie
        dateMovieLabel.text = dateMovie
        scoreMovieLabel.text = scoreMovie
    }

    // MARK: - Private Methods

    private func addSubview() {
        addSubview(imageMovieImageView)
        addSubview(nameMovieLabel)
        addSubview(descriptionMovieLabel)
        addSubview(dateMovieLabel)
        addSubview(scoreMovieLabel)
    }

    private func setupConstraint() {
        createNameMovieLabelConstraint()
        createDescriptionMovieLabelConstraint()
        createDateMovieLabelConstraint()
        createScoreMovieLabelConstraint()
        createImageMovieImageViewConstraint()
    }

    private func createNameMovieLabelConstraint() {
        nameMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameMovieLabel.topAnchor.constraint(equalTo: topAnchor),
            nameMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor),
            nameMovieLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameMovieLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func createDescriptionMovieLabelConstraint() {
        descriptionMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionMovieLabel.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor),
            descriptionMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor),
            descriptionMovieLabel.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionMovieLabel.bottomAnchor.constraint(equalTo: dateMovieLabel.topAnchor)
        ])
    }

    private func createDateMovieLabelConstraint() {
        dateMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor),
            dateMovieLabel.rightAnchor.constraint(equalTo: rightAnchor),
            dateMovieLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dateMovieLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func createScoreMovieLabelConstraint() {
        scoreMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreMovieLabel.bottomAnchor.constraint(equalTo: imageMovieImageView.bottomAnchor, constant: -10),
            scoreMovieLabel.rightAnchor.constraint(equalTo: imageMovieImageView.rightAnchor, constant: -10),
            scoreMovieLabel.widthAnchor.constraint(equalToConstant: 50),
            scoreMovieLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: topAnchor),
            imageMovieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageMovieImageView.widthAnchor.constraint(equalToConstant: 150),
            imageMovieImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
