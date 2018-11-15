//
//  Movie.swift
//  flix
//
//  Created by Allen Lozano on 11/14/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import Foundation
class Movie{
    
    var title: String
    var posterUrl: URL?
    var posterPathUrlString: String
    var overview: String?
    var releaseDate: String
    //var backDropPath: String
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        posterPathUrlString = (dictionary["poster_path"] as? String)!
        overview = dictionary["overview"] as? String 
        releaseDate = dictionary["release_date"] as! String
        //backDropPath = dictionary["dropback_path"] as! String
    }
}
