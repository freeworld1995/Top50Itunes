//
//  SongCell.swift
//  TopItunes
//
//  Created by Jimmy Hoang on 1/27/17.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
