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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
