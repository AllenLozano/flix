//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Allen Lozano on 9/21/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [[String: Any]] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
       
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:22, right: 40)
        super.viewDidLoad()
        self.tableView.rowHeight = 200
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        fetchMovies()
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        activityIndicator.startAnimating()
        fetchMovies()
        
    }
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b0dc70014ba202070fef1eba8a6cd6be" )!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data,response,error) in
            //this will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data{
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
                
            }
            
        }
        
        task.resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
      
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
        
            let movie =  movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
