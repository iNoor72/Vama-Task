//
//  MovieDetailsViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var movie: MovieViewItem? { get }
    var successCompletion: (() -> ())? { get set }
    var failureCompletion: (() -> ())? { get set }
    
    func fetchMovieDetails() async
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    var movieID: Int = 0
    var movie: MovieViewItem?
    var successCompletion: (() -> ())?
    var failureCompletion: (() -> ())?
    
    init(movieDetailsRepository: MovieDetailsRepositoryProtocol) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    func fetchMovieDetails() async {
        guard let result = await movieDetailsRepository.fetchMovieDetails(movieID: movieID) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let movie):
            self.movie = MovieViewItem(id: movie.id ?? 0, uuid: movie.uuid, title: movie.title ?? "", posterPath: movie.posterPath ?? "", releaseDate: movie.releaseDate ?? "", rating: movie.rating ?? 0, overview: movie.overview ?? "")
            successCompletion?()
        }
    }
}
