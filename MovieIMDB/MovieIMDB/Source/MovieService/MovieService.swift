//
//  MovieService.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import Foundation

protocol Service{
    func fetchPopularMovies(completion: @escaping ([MovieModel]?) -> Void)
    func saveMoviesToCoreData(_ movies: [MovieModel])
}

class MovieService: Service {
    private let apiKey = "38a73d59546aa378980a88b645f487fc"
    
    func fetchPopularMovies(completion: @escaping ([MovieModel]?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(MovieResponse.self, from: data)
                
                let movies = apiResponse.results.map { result in
                    return MovieModel(
                        title: result.title,
                        thumbnail: result.posterPath,
                        rating: result.voteAverage,
                        playlist: nil
                    )
                }
                // Save fetched movies to Core Data
                self.saveMoviesToCoreData(movies)
                completion(movies)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func saveMoviesToCoreData(_ movies: [MovieModel]) {
        let context = CoredataContainer.shared.persistentContainer.viewContext
        
        for movie in movies {
            let movieManagedObject = Movie(context: context)
            movieManagedObject.title = movie.title
            movieManagedObject.thumbnail = movie.thumbnail
            movieManagedObject.rating = movie.rating
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving movies to Core Data: \(error.localizedDescription)")
        }
    }
}



