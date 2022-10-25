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
        static let popularQueryText = "popular?"
        static let upcomingQueryText = "upcoming?"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
        static let moviesText = "Movies"
        static let popularText = "Popular"
        static let topRatedText = "Top Rated"
        static let upComingText = "Up Coming"
        static let movieTableViewCellText = "MovieTableViewCell"
    }

    // MARK: - Private Visual Properties

    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popularText, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(popularButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var topRatedButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.topRatedText, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(topRatedButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var upComingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upComingText, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(upComingButtonAction), for: .touchUpInside)
        return button
    }()

    private let mainActivityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = .systemPink
        activity.startAnimating()
        return activity
    }()

    private let listMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieTableViewCellText)
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .none
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

    @objc private func popularButtonAction() {
        listMoviesTableView.reloadData()
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        fetchData(categoryMovies: Constants.popularQueryText)
    }

    @objc private func topRatedButtonAction() {
        listMoviesTableView.reloadData()
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        fetchData(categoryMovies: Constants.topRatedQueryText)
    }

    @objc private func upComingButtonAction() {
        listMoviesTableView.reloadData()
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        fetchData(categoryMovies: Constants.upcomingQueryText)
    }

    private func setupView() {
        title = Constants.moviesText
        fetchData(categoryMovies: Constants.popularQueryText)
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
        view.addSubview(mainActivityIndicatorView)
    }

    private func setupConstraint() {
        createPopularButtonConstraint()
        createTopRatedButtonConstraint()
        createUpComingButtonConstraint()
        createListMoviesTableViewConstraint()
        createMainActivityIndicatorViewConstraint()
    }

    private func fetchData(categoryMovies: String) {
        let urlString = Constants.themoviedbQueryText + categoryMovies + Constants
            .apiKeyQueryText + Constants.languageQueryText + Constants.pageQueryText + Constants.pageQueryText
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }
                if error == nil {
                    self.decodeData(data: data)
                    self.getDataImageFromURLImage()
                    DispatchQueue.main.async {
                        self.mainActivityIndicatorView.stopAnimating()
                        self.mainActivityIndicatorView.isHidden = true
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

    func getDataImageFromURLImage() {
        guard let safeMovies = movies else { return }
        for index in 0 ..< safeMovies.count {
            guard
                let imageMovieNameURL =
                URL(string: "\(Constants.posterPathQueryText)" + "\(safeMovies[index].posterPath)")
            else { continue }
            movies?[index].dataImage = try? Data(contentsOf: imageMovieNameURL)
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

    private func createMainActivityIndicatorViewConstraint() {
        mainActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainActivityIndicatorView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -30),
            mainActivityIndicatorView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
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
            dataImage: safeMovies[indexPath.row].dataImage,
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
