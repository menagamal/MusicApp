//
//  AlbumViewModel.swift
//  MusicApp
//
//  Created by Mena Gamal on 6/21/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//


import Foundation
import UIKit

class AlbumsViewModel {
    
    var album:AlbumModel!
    
    var vc: UIViewController!
    
    var view:AlbumView!
    
    public enum Action {
        case  wait, idel, onError(str: String) ,getAllAlbums(albums:[AlbumModel])
    }
    
    init( view:AlbumView,vc: UIViewController) {
        self.view = view
        self.vc = vc
        self.album = AlbumModel(viewModel:self)

        
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
        case .getAllAlbums(let albums):
            view.update(action: .getAllAlbums(albums: albums))
            break
        }
        
    }
    
    func getAllAlbums(str:String) {
        album.getArtistAlbums(str: str)
    }
    
    
    
    
}
