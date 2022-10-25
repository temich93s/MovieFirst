// ListMoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Экран со списком фильмов

final class ListMoviesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let apiKeyQueryText = "api_key=8216e974d625f2a458a739c20007dcd6"
        static let languageQueryText = "&language=ru-RU"
        static let pageQueryText = "&page=1"
        static let regionQueryText = "&region=ru"
        static let topRatedQueryText = "top_rated?"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
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
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .blue
        return tableView
    }()

    // MARK: - Private Properties

    var movies: [Movie]? = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .orange
        title = Constants.moviesText

        fetchData()
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

    private func fetchData() {
        let urlString = Constants.themoviedbQueryText + Constants.topRatedQueryText + Constants
            .apiKeyQueryText + Constants.languageQueryText + Constants.pageQueryText + Constants.pageQueryText
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }
                if error == nil {
                    self.decodeData(data: data)
                    DispatchQueue.main.async {
                        self.listMoviesTableView.reloadData()
                    }
                } else {
                    print(error ?? "")
                }
            }
            task.resume()
        }
    }

    func decodeData(data: Data?) {
        let decoder = JSONDecoder()
        if let safeData = data {
            do {
                let decodedData = try decoder.decode(MovieList.self, from: safeData)
                movies = decodedData.results
            } catch {
                print(error)
            }
        }
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
        movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieTableViewCellText) as? MovieTableViewCell,
            let safeMovies = movies
        else { return UITableViewCell() }
        cell.configureMovieTableViewCell(
            imageMovieName: safeMovies[indexPath.row].posterPath,
            nameMovie: safeMovies[indexPath.row].title,
            descriptionMovie: safeMovies[indexPath.row].overview,
            dateMovie: safeMovies[indexPath.row].releaseDate,
            scoreMovie: "\(safeMovies[indexPath.row].voteAverage)"
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMovieViewController = CurrentMovieViewController()
        navigationController?.pushViewController(currentMovieViewController, animated: true)
    }
}
