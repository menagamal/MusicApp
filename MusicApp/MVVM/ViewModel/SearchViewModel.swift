//
//  SearchViewModel.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/20/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel {
    
    var artist:Artist!
    
    var vc: UIViewController!
    
    var view:SearchView!
    
    public enum Action {
        case  wait, idel, onError(str: String) ,searchArtists(artists:[Artist])
    }
    
    init( view:SearchView,vc: UIViewController) {
        self.view = view
        self.vc = vc
        self.artist = Artist(viewModel: self)
        
    }
    
    func update(action: Action) {
        
        switch action {
        case .wait:
            view.update(action: .wait)
            break
        case .idel:
            view.update(action: .idel)
            break
        case .onError(let str):
            view.update(action: .onError(str: str))
            break
        case .searchArtists(let artists) :
            view.update(action: .searchArtists(artists: artists))
            break
        }
        
    }
    func searchArtist(str:String)  {
        artist.searchArtist(str: str)
    }
    
}
