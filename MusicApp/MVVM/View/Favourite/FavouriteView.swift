//
//  FavouriteView.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

protocol FavouriteView {
    
    var favouriteViewModel: FavouriteViewModel! {
        get set
    }
    
    func update(action: FavouriteViewModel.Action)
}

