//
//  SearchTableViewCell.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelArtistListeners: UILabel!
    @IBOutlet weak var labelArtistName: UILabel!
    
    func setDetails(artist:Artist)  {
        labelArtistName.text = artist.name
        labelArtistListeners.text = artist.listeners
    }
}
