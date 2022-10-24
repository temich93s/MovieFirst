// ListMoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Экран со списком фильмов

final class ListMoviesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let moviesText = "Movies"
        static let popularText = "Popular"
        static let topRatedText = "Top Rated"
        static let upComingText = "Up Coming"
        static let movieTableViewCellText = "MovieTableViewCell"
        static let defaultImageMovieNameText = "Lightwire - Over Powered"
        static let defaultNameMovieText = "Lightwire - Over Powered"
        static let defaultDescriptionMovieText = "Хороший фильм"
        static let defaultDateMovieText = "23.05.2022"
        static let defaultScoreMovieText = "7.7"
    }

    // MARK: - Private Visual Properties

    private var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popularText, for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    private var topRatedButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.topRatedText, for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    private var upComingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upComingText, for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    private var listMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieTableViewCellText)
        tableView.backgroundColor = .blue
        return tableView
    }()

    private var movieTableViewCell: UITableViewCell = {
        let tableView = UITableViewCell()
        tableView.backgroundColor = .green
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .orange
        title = Constants.moviesText

        listMoviesTableView.delegate = self
        listMoviesTableView.dataSource = self
        addSubview()
        setupConstraint()
    }

    private func addSubview() {
        view.addSubview(popularButton)
        view.addSubview(topRatedButton)
        view.addSubview(upComingButton)
        view.addSubview(listMoviesTableView)
    }

    private func setupConstraint() {
        createPopularButtonConstraint()
        createTopRatedButtonConstraint()
        createUpComingButtonConstraint()
        createListMoviesTableViewConstraint()
    }

    private func createPopularButtonConstraint() {
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            popularButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            popularButton.widthAnchor.constraint(equalTo: topRatedButton.widthAnchor),
            popularButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func createTopRatedButtonConstraint() {
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            topRatedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topRatedButton.heightAnchor.constraint(equalToConstant: 40),
            topRatedButton.leftAnchor.constraint(equalTo: popularButton.rightAnchor, constant: 10),
        ])
    }

    private func createUpComingButtonConstraint() {
        upComingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upComingButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            upComingButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            upComingButton.widthAnchor.constraint(equalTo: topRatedButton.widthAnchor),
            upComingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func createListMoviesTableViewConstraint() {
        listMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listMoviesTableView.topAnchor.constraint(equalTo: topRatedButton.bottomAnchor, constant: 5),
            listMoviesTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            listMoviesTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            listMoviesTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieTableViewCellText) as? MovieTableViewCell
        else { return UITableViewCell() }
        cell.configureMovieTableViewCell(
            imageMovieName: Constants.defaultImageMovieNameText,
            nameMovie: Constants.defaultNameMovieText,
            descriptionMovie: Constants.defaultDescriptionMovieText,
            dateMovie: Constants.defaultDateMovieText,
            scoreMovie: Constants.defaultScoreMovieText
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMovieViewController = CurrentMovieViewController()
        navigationController?.pushViewController(currentMovieViewController, animated: true)
    }
}
