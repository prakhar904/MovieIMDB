//
//  MovieListViewModel.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import Foundation
import CoreData

class MovieListViewModel {
    private let movieService = MovieService()
    private var movies: [MovieModel] = []
    private let context = CoredataContainer.shared.persistentContainer.viewContext

    
    var numberOfMovies: Int {
        return movies.count
    }
    
    func fetchMovies(completion: @escaping () -> Void) {
        movieService.fetchPopularMovies { [weak self] movies in
            if let movies = movies {
                self?.movies = movies
            }
            else{
                self?.fetchLocalMovies { localMovies in
                    if let localMovies = localMovies {
                        self?.movies = localMovies.map{
                            MovieModel(title: $0.title ?? "", thumbnail: $0.thumbnail ?? "", rating: $0.rating )
                        }
                    } else {
                        completion()
                    }
                }
            }
            completion()
        }
    }
    
    private func fetchLocalMovies(completion: @escaping ([Movie]?) -> Void) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            let movies = try context.fetch(fetchRequest)
            completion(movies)
        } catch {
            print("Error fetching local movies: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    func movie(at index: Int) -> MovieModel? {
        guard index >= 0, index < movies.count else {
            return nil
        }
        return movies[index]
    }
    
    
}

