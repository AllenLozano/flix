//
//  MovieCell.swift
//  flix
//
//  Created by Allen Lozano on 9/22/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var movie: Movie!{
        didSet{
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let posterPathUrl = URL(string: baseUrlString + movie.posterPathUrlString)!
            posterImageView.af_setImage(withURL: posterPathUrl)
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
