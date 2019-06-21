//
//  AlbumView.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//


import Foundation
import UIKit

protocol AlbumView {
    
    var albumViewModel: AlbumsViewModel! {
        get set
    }
    
    func update(action: AlbumsViewModel.Action)
}

