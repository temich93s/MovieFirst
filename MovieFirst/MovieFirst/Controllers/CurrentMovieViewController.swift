// CurrentMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Экран с выбранным фильмом

final class CurrentMovieViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let overviewText = "Overview"
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
        static let systemPinkColorName = "SystemPinkColor"
        static let releaseDataLabelText = "Дата релиза:"
        static let voteAverageLabelText = "Оценка:"
        static let voteCountLabelText = "Голоса:"
    }

    // MARK: - Private Visual Properties

    private let imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: Constants.systemPinkColorName)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private let releaseDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.releaseDataLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let releaseDataValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.voteAverageLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteAverageValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.voteCountLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteCountValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let overviewMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView = UIView()

    // MARK: - Initializers

    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        getDataImageFromURLImage(posterPath: movie.posterPath)
        titleMovieLabel.text = movie.title
        releaseDataValueLabel.text = movie.releaseDate
        voteAverageValueLabel.text = "\(movie.voteAverage)"
        voteCountValueLabel.text = "\(movie.voteCount)"
        overviewMovieLabel.text = movie.overview
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        title = Constants.overviewText
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.systemPinkColorName)
        addSubview()
        setupConstraint()
    }

    private func addSubview() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(imageMovieImageView)
        contentView.addSubview(titleMovieLabel)
        contentView.addSubview(releaseDataLabel)
        contentView.addSubview(releaseDataValueLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(voteAverageValueLabel)
        contentView.addSubview(voteCountLabel)
        contentView.addSubview(voteCountValueLabel)
        contentView.addSubview(overviewMovieLabel)
    }

    private func setupConstraint() {
        createImageMovieImageViewConstraint()
        createTitleMovieLabelConstraint()
        createReleaseDataLabelConstraint()
        createReleaseDataValueLabelConstraint()
        createVoteAverageLabelConstraint()
        createVoteAverageValueLabelConstraint()
        createVoteCountLabelConstraint()
        createVoteCountValueLabelConstraint()
        createOverviewMovieLabelConstraint()
        createMainScrollViewConstraint()
        createContentViewConstraint()
    }

    func getDataImageFromURLImage(posterPath: String) {
        guard let imageMovieNameURL = URL(string: "\(Constants.posterPathQueryText)" + "\(posterPath)") else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageMovieNameURL) else { return }
            DispatchQueue.main.async {
                self.imageMovieImageView.image = UIImage(data: data)
            }
        }
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageMovieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMovieImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: imageMovieImageView.widthAnchor, multiplier: 1.5)
        ])
    }

    private func createTitleMovieLabelConstraint() {
        titleMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleMovieLabel.topAnchor.constraint(equalTo: imageMovieImageView.bottomAnchor, constant: 20),
            titleMovieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleMovieLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func createReleaseDataLabelConstraint() {
        releaseDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDataLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 20),
            releaseDataLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            releaseDataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createReleaseDataValueLabelConstraint() {
        releaseDataValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDataValueLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 20),
            releaseDataValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            releaseDataValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createVoteAverageLabelConstraint() {
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAverageLabel.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 10),
            voteAverageLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            voteAverageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createVoteAverageValueLabelConstraint() {
        voteAverageValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAverageValueLabel.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 10),
            voteAverageValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            voteAverageValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createVoteCountLabelConstraint() {
        voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteCountLabel.topAnchor.constraint(equalTo: voteAverageValueLabel.bottomAnchor, constant: 10),
            voteCountLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            voteCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createVoteCountValueLabelConstraint() {
        voteCountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteCountValueLabel.topAnchor.constraint(equalTo: voteAverageValueLabel.bottomAnchor, constant: 10),
            voteCountValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            voteCountValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createOverviewMovieLabelConstraint() {
        overviewMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overviewMovieLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor, constant: 20),
            overviewMovieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overviewMovieLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            overviewMovieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func createMainScrollViewConstraint() {
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    private func createContentViewConstraint() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor)
        ])
    }
}
